//
//  CommandLineParser.h
//  RunningProcessInfo
//
//  Created by Grigory Zubankov on 9/4/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// RunningProcessInfo
#import "CommandLineParser.h"
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
  
  // allocate enough memory for all argments
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
  // check input parameters
  if (buffer == nil || bufSize < sizeof(int))
  {
    return nil;
  }
  
  // get argument count
  int argCount = *((int*)buffer);
  if (argCount < 1)
  {
    return nil;
  }
  
  // move pointer to executable path
  char const* cp = buffer + sizeof(argCount);
  char const* cpEnd = buffer + bufSize;
  
  // skip executable path
  for (; cp < cpEnd && *cp != '\0'; ++cp)
  {
  }
  // skip trailing '\0' characters
  for (; cp < cpEnd && *cp == '\0'; ++cp)
  {
	}
  
  NSMutableArray* args = [[NSMutableArray alloc] init];
  
  // reached arg0 - read all args
  char const* cpArgN = cp;
  int arg = 0;
  for (; cp < cpEnd && arg < argCount; ++cp)
  {
    if (*cp == '\0')
    {
      ++arg;
      NSString* argN = [NSString stringWithCString: cpArgN encoding: NSUTF8StringEncoding];
      [args addObject: argN];
      // set net cpArgN
      cpArgN = cp + 1;
    }
  }
  
  // are all argumets parsed?
  if (arg != argCount)
  {
    return nil;
  }

  // all Ok
  return args;
}
