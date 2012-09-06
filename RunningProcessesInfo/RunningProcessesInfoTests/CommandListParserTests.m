//
//  CommandListParserTest.m
//  RunningProcessesInfo
//
//  Created by Grigory Zubankov on 9/4/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// Test
#import "CommandListParserTests.h"
// Dependencies
#import "../RunningProcessesInfo/include/CommandLineParser.h"


#define CALL_PARSER(buffer) \
  ParseProcessArguments(buffer, sizeof(buffer) - 1)

// arguments names
#define TEST_AGR0 "Arg0"
#define TEST_AGR1 "Arg1"
#define TEST_AGR2 "Arg2"
#define TEST_AGR3 "Arg3"
#define TEST_AGR4 "Arg4"
#define TEST_AGR5 "Arg5"
#define TEST_AGR6 "Arg6"

// other elements
#define TEST_EXECPATH "ExecPath"

char arg[][5] = {TEST_AGR0, TEST_AGR1, TEST_AGR2, TEST_AGR3, TEST_AGR4, TEST_AGR5, TEST_AGR6};

// incorrect buffers
char const bufferWithZeroArgCount[] = "\0\0\0\0";
char const bufferWithNoExecPath[] = "\1\0\0\0";
char const bufferWithNoTrailingZeroesAfterExecPath[] = "\1\0\0\0" TEST_EXECPATH;
char const bufferWithNoArguments[] = "\1\0\0\0" TEST_EXECPATH "\0";
char const bufferWithNoTrailingZeroAfterArgument[] = "\1\0\0\0" TEST_EXECPATH "\0" TEST_AGR0;
char const bufferWithIncorrectArgCount2[] = "\2\0\0\0" TEST_EXECPATH "\0" TEST_AGR0 "\0";
char const bufferWithIncorrectArgCount7[] = "\7\0\0\0" TEST_EXECPATH "\0" TEST_AGR0 "\0" TEST_AGR1 "\0" TEST_AGR2 "\0" TEST_AGR3 "\0" TEST_AGR4 "\0" TEST_AGR5 "\0";

// correct buffers
char const bufferWithArgCount1[] = "\1\0\0\0" TEST_EXECPATH "\0" TEST_AGR0 "\0";
char const bufferWithArgCount6[] = "\6\0\0\0" TEST_EXECPATH "\0" TEST_AGR0 "\0" TEST_AGR1 "\0" TEST_AGR2 "\0" TEST_AGR3 "\0" TEST_AGR4 "\0" TEST_AGR5 "\0";


//
// CommandListParserTest
//

@implementation CommandListParserTest

- (void) testIncorrectInputParameters
{
  char const* invalidNotNullPointer = (char const*)1;
  //
  STAssertNil(ParseProcessArguments(0, 1), @"nil buffer test");
  STAssertNil(ParseProcessArguments(invalidNotNullPointer, 0), @"zero size test");
  STAssertNil(ParseProcessArguments(invalidNotNullPointer, sizeof(int) - 1), @"sizeof(int) - 1 size test");
}

- (void) testIncorrectBufferFormat
{
  STAssertNil(CALL_PARSER(bufferWithZeroArgCount), nil);
  STAssertNil(CALL_PARSER(bufferWithNoExecPath), nil);
  STAssertNil(CALL_PARSER(bufferWithNoTrailingZeroesAfterExecPath), nil);
  STAssertNil(CALL_PARSER(bufferWithNoArguments), nil);
  STAssertNil(CALL_PARSER(bufferWithNoTrailingZeroAfterArgument), nil);
  STAssertNil(CALL_PARSER(bufferWithIncorrectArgCount2), nil);
  STAssertNil(CALL_PARSER(bufferWithIncorrectArgCount7), nil);
}

- (void) testSixArgs
{
  NSArray* array = CALL_PARSER(bufferWithArgCount6);
  STAssertTrue([[array objectAtIndex: 0] isEqualToString: [self toString: arg[0]]], nil);
  STAssertTrue([[array objectAtIndex: 1] isEqualToString: [self toString: arg[1]]], nil);
  STAssertTrue([[array objectAtIndex: 2] isEqualToString: [self toString: arg[2]]], nil);
  STAssertTrue([[array objectAtIndex: 3] isEqualToString: [self toString: arg[3]]], nil);
  STAssertTrue([[array objectAtIndex: 4] isEqualToString: [self toString: arg[4]]], nil);
  STAssertTrue([[array objectAtIndex: 5] isEqualToString: [self toString: arg[5]]], nil);
}

- (void) testOneArgs
{
  NSArray* array = CALL_PARSER(bufferWithArgCount1);
  STAssertTrue([[array objectAtIndex: 0] isEqualToString: [self toString: arg[0]]], nil);
}

- (void) testArgCount
{
  STAssertTrue([CALL_PARSER(bufferWithArgCount1) count] == 1, nil);
  STAssertTrue([CALL_PARSER(bufferWithArgCount6) count] == 6, nil);
}

- (void) testNotNilResult
{
  STAssertNotNil(CALL_PARSER(bufferWithArgCount1), nil);
  STAssertNotNil(CALL_PARSER(bufferWithArgCount6), nil);
}

// helpers

- (NSString*) toString: (char const*) cstr
{
  return [NSString stringWithCString: cstr encoding: NSUTF8StringEncoding];
}

@end
