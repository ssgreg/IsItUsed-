//
//  JetStream.h
//  RunningProcessInfo
//
//  Created by Grigory Zubankov on 26.11.12
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//


//
// JetStream
//

@protocol JetStream

- (NSInteger) getSize;
- (bool) hasData: (NSInteger) size;
- (NSData*) readData: (NSInteger) size;
- (NSData*) readDataToDelimiter: (char) delimiter;
- (NSInteger) readInteger;
- (NSString*) readString;

@end
