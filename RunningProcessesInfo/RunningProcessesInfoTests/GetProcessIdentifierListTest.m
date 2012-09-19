//
//  GetProcessIdentifierListTest.m
//  RunningProcessesInfo
//
//  Created by Grigory Zubankov on 9/12/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// Test
#import "GetProcessIdentifierListTest.h"
// Dependencies
#import "../RunningProcessesInfo/include/GetProcessIdentifierList.h"


NSInteger const defaultBufferIncrement = sizeof(pid_t) * 32;


//
// TestPidGetterNilResultForNilBuffer
//

@interface TestPidGetterNilResultForNilBuffer : NSObject<JetPidGetterProtocol>
@end

@implementation TestPidGetterNilResultForNilBuffer

- (int) copyPidsToBuffer:(void*) buffer size:(int) size
{
  if (buffer == nil)
  {
    return 0;
  }
  return 100;
}

@end


//
// TestPidGetterNilResultForNotNilBuffer
//

@interface TestPidGetterNilResultForNotNilBuffer : NSObject<JetPidGetterProtocol>
@end

@implementation TestPidGetterNilResultForNotNilBuffer

- (int) copyPidsToBuffer:(void*) buffer size:(int) size
{
  if (buffer != nil)
  {
    return 0;
  }
  return 100;
}

@end


//
// TestPidGetterCallCounter
//

@interface TestPidGetterCallCounter : NSObject<JetPidGetterProtocol>

- (NSInteger) GetCallCount;

@end

@implementation TestPidGetterCallCounter
{
@private
  NSInteger theCallCount;
  int theBufferSize;
}

- (id) initWithBufferSize:(int) bufferSize
{
  if (self = [super init])
  {
    theCallCount = 0;
    theBufferSize = bufferSize;
  }
  return self;
}

- (int) copyPidsToBuffer:(void*) buffer size:(int) size
{
  ++theCallCount;
  return theBufferSize;
}

- (NSInteger) GetCallCount
{
  return theCallCount;
}

@end


//
// TestPidGetterSimpleResult
//

@interface TestPidGetterSimpleResult : NSObject<JetPidGetterProtocol>
@end

@implementation TestPidGetterSimpleResult

- (int) copyPidsToBuffer:(void*) buffer size:(int) size
{
  if (buffer != nil)
  {
    *((pid_t*)buffer) = 42;
  }
  return 1 * sizeof(pid_t);
}

@end


//
// TestPidGetterComplexResult
//

@interface TestPidGetterComplexResult : NSObject<JetPidGetterProtocol>
@end

@implementation TestPidGetterComplexResult
{
  NSInteger theCallCount;
  NSMutableData* theBuffer;
}

- (id) init
{
  if (self = [super init])
  {
    theCallCount = 0;
    theBuffer = [NSMutableData dataWithLength: defaultBufferIncrement * 3];
    memset([theBuffer bytes], 1, [theBuffer length]);
  }
  return self;
}

- (int) copyPidsToBuffer:(void*) buffer size:(int) size
{
  ++theCallCount;
  if (buffer != nil && size >= defaultBufferIncrement * 3)
  {
    memcpy(buffer, [theBuffer bytes], [theBuffer length]);
  }
  if (theCallCount == 1) return 1;
  if (theCallCount == 2) return defaultBufferIncrement * 1;
  if (theCallCount == 3) return defaultBufferIncrement * 2;
  if (theCallCount >= 4) return defaultBufferIncrement * 3;
}

- (bool) checkCallCount
{
  return theCallCount == 5;
}

- (bool) checkArrayObjectCount:(NSArray*) array
{
  return [array count] == defaultBufferIncrement * 3 / sizeof(pid_t);
}

- (bool) checkIsNSArrayIsCorrect:(NSArray*) array
{
  for(NSNumber* num in array)
  {
    if ([num intValue] != 0x01010101)
    {
      return false;
    }
  }
  return true;
}

@end


//
// GetProcessIdentifierListTest
//

@implementation GetProcessIdentifierListTest

- (void) testNilResultForIncorrectPidGetter
{
  STAssertNil(JetGetPidListInternal([[TestPidGetterNilResultForNilBuffer alloc] init]), nil);
  STAssertNil(JetGetPidListInternal([[TestPidGetterNilResultForNotNilBuffer alloc] init]), nil);
}

- (void) testPidGetterIsCalledTwice
{
  TestPidGetterCallCounter* pidGetter = [[TestPidGetterCallCounter alloc] initWithBufferSize: defaultBufferIncrement - sizeof(pid_t)];
  JetGetPidListInternal(pidGetter);
  STAssertTrue([pidGetter GetCallCount] == 2, nil);
}

- (void) testPidGetterIsCalledThrice
{
  TestPidGetterCallCounter* pidGetter = [[TestPidGetterCallCounter alloc] initWithBufferSize: defaultBufferIncrement];
  JetGetPidListInternal(pidGetter);
  STAssertTrue([pidGetter GetCallCount] == 3, nil);
}

- (void) testSimpleCase
{
  NSArray* array = JetGetPidListInternal([[TestPidGetterSimpleResult alloc] init]);
  STAssertTrue([array count] == 1, nil);
  STAssertTrue([[array objectAtIndex: 0] intValue] == 42, nil);
}

- (void) testComplexCase
{
  TestPidGetterComplexResult* pidGetter = [[TestPidGetterComplexResult alloc] init];
  NSArray* array = JetGetPidListInternal(pidGetter);
  STAssertNotNil(array, nil);
  STAssertTrue([pidGetter checkCallCount], nil);
  STAssertTrue([pidGetter checkArrayObjectCount: array], nil);
  STAssertTrue([pidGetter checkIsNSArrayIsCorrect: array], nil);
}

@end