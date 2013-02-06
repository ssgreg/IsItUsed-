//
//  CommandLineParser.h
//  RunningProcessInfo
//
//  Created by Grigory Zubankov on 9/4/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// RunningProcessInfo
#import "CommandLineParser.h"
#import "JetStream.h"
#import "JetMemoryStream.h"
// sys
#include <sys/sysctl.h>


#define SIZE_OF_MIB(mib) \
  (sizeof(mib) / sizeof(*mib) - 1)


//
// JetGetProcessArguments
//

NSArray* JetGetProcessArguments(pid_t pid)
{
  size_t bufSize = 0;
  size_t bufSizeSize = sizeof(bufSize);
  
  // get buffer size for all arguments
  int mibArgMax[] = { CTL_KERN, KERN_ARGMAX, 0 };
  if (sysctl(mibArgMax, SIZE_OF_MIB(mibArgMax), &bufSize, &bufSizeSize, NULL, 0) < 0)
  {
    return nil;
  }
  
  // allocate enough memory for all arguments
  NSMutableData* data = [NSMutableData dataWithLength: bufSize];
  char* buffer = [data mutableBytes];
  
  // get all arguments to the buffer
  int mibArgs[] = { CTL_KERN, KERN_PROCARGS2, pid, 0 };
  if (sysctl(mibArgs, SIZE_OF_MIB(mibArgs), buffer, &bufSize, NULL, 0) < 0)
  {
    return nil;
  }

  return JetParseProcessArguments(buffer, bufSize);
}


//
// ParseProcessArguments
//

NSArray* JetParseProcessArguments(char const* buffer, size_t bufSize)
{
  JetMemoryStream* stream = [[JetMemoryStream alloc] initWithData: [NSData dataWithBytesNoCopy: buffer length: bufSize freeWhenDone: NO]];

  // read argument count
  int argCount = [stream readInteger];
  if (argCount < 1)
  {
    return nil;
  }

  // skip executable path
  if (![stream readString])
  {
    return nil;
  }

  // read arguments
  int curArg = 0;
  NSMutableArray* args = [[NSMutableArray alloc] init];
  for (; curArg < argCount; ++curArg)
  {
    NSString* argN = [stream readString];
    if (!argN)
    {
      return nil;
    }
    [args addObject: argN];
  }

  // are not all arguments parsed? is remaining buffer not empty?
  if (curArg != argCount || [stream hasData: 1])
  {
    return nil;
  }

  return args;
}
