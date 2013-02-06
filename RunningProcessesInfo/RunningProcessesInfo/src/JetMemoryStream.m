//
//  JetMemoryStream.h
//  RunningProcessInfo
//
//  Created by Grigory Zubankov on 26.11.12
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "JetMemoryStream.h"


@implementation JetMemoryStream
{
  NSData* theData;
  NSInteger theCurPos;
}

- (id) initWithData: (NSData*) data
{
  if (!(self = [super init]))
  {
    return 0;
  }
  //
  theData = data;
  theCurPos = 0;
  //
  return self;
}

- (NSInteger) getSize
{
  return [theData length] - theCurPos;
}

- (bool) hasData: (NSInteger) size
{
  if (size > [self getSize])
  {
    return NO;
  }
  return YES;
}

- (NSData*) readData: (NSInteger) size
{
  if ([self hasData: size] == NO || size == 0)
  {
    return nil;
  }
  NSMutableData* data = [NSMutableData dataWithLength: size];
  void* buffer = [data mutableBytes];
  [theData getBytes: buffer range:NSMakeRange(theCurPos, size)];
  // read done - increment position
  theCurPos += size;
  return data;
}

- (NSData*) readDataToDelimiter: (char) delimiter;
{
  // calculate size to read
  // this algorithm does not work with stack-like single-read stream sources
  NSInteger size = 0;
  char* buffer = [theData bytes];
  bool isDelimiterFound = NO;
  for (; size < [self getSize]; ++size)
  {
    if (buffer[theCurPos + size] == delimiter)
    {
      // skip delimiter
      ++size;
      break;
    }
  }
  NSData* data = [self readData: size];
  return data;
}

- (NSInteger) readInteger
{
  NSData* data = [self readData: sizeof(int)];
  if (!data)
  {
    return 0;
  }
  return *(int*)[data bytes];
}

- (NSString*) readString
{
  NSData* data = [self readDataToDelimiter: '\0'];
  if (!data || ((char const*)[data bytes])[[data length] - 1] != '\0')
  {
    return nil;
  }
  return [NSString stringWithCString: [data bytes] encoding: NSUTF8StringEncoding];
}


@end
