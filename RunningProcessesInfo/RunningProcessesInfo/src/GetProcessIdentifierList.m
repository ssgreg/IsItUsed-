//
//  GetProcessIdentifierList.cpp
//
//  Created by Grigory Zubankov on 9/12/12
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// Test
#import <GetProcessIdentifierList.h>
// libproc
#import <libproc.h>
#import "GetProcessIdentifierList.h"


//
// JetGetProcessIdentifierData
//

NSData* JetGetProcessIdentifierData(id<JetPidGetterProtocol> pidGetter)
{
  int const sizeStepIncrement = sizeof(pid_t) * 32;

  // determine how many bytes are needed to contain pid list
  int requiredSize = 0;
  if ((requiredSize = [pidGetter copyPidsToBuffer: nil size: 0]) <= 0)
  {
    return nil;
  }

  // fix memory size (multiple of sizeIncrement)
  int pidListSize = (requiredSize + sizeStepIncrement - 1) / sizeStepIncrement * sizeStepIncrement;

  // allocate memory for all pids in the list
  NSMutableData* data = [NSMutableData dataWithLength: pidListSize];

  int pidCount = 0;
  // try to get all pids at _once_
  for (;;)
  {
    if ((requiredSize = [pidGetter copyPidsToBuffer: [data mutableBytes] size: pidListSize]) <= 0)
    {
      return nil;
    }
    pidCount = requiredSize / sizeof(pid_t);

    // buffer should be bigger at least by one pid
    if (requiredSize + sizeof(pid_t) <= pidListSize)
    {
      break;
    }
    else
    {
      // reallocate bigger buffer
      [data increaseLengthBy: sizeStepIncrement];
      pidListSize = (int)[data length];
    }
  }

  // set real size
  [data setLength: pidCount * sizeof(pid_t)];
  return data;
}


//
// JetLibprocBasedPidGetter
//

@interface JetLibprocBasedPidGetter : NSObject<JetPidGetterProtocol>
@end

@implementation JetLibprocBasedPidGetter

- (int) copyPidsToBuffer:(void*) buffer size:(int) size
{
  return proc_listpids(PROC_ALL_PIDS, 0, buffer, size);
}

@end


//
// JetGetProcessIdentifierList
//

NSArray* JetGetProcessIdentifierList()
{
  return JetGetPidListInternal([[JetLibprocBasedPidGetter alloc] init]);
}


//
// JetGetPidListInternal
//

NSArray* JetGetPidListInternal(id<JetPidGetterProtocol> pidGetter)
{
  // get all pids
  NSData* data = JetGetProcessIdentifierData(pidGetter);
  if (!data)
  {
    return nil;
  }
  //
  NSInteger pidCount = [data length] / sizeof(pid_t);
  pid_t const* pids = (pid_t const*)[data bytes];

  // enumerate all pids
  NSMutableArray* processes = [[NSMutableArray alloc] init];
  for (int i = 0; i < pidCount; ++i)
  {
    pid_t pid = pids[i];
    if (pid != 0)
    {
      [processes addObject: [NSNumber numberWithInt: pid]];
    }
  }

  return processes;
}

