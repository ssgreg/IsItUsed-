//
//  JetMemoryStream.h
//  RunningProcessInfo
//
//  Created by Grigory Zubankov on 26.11.12
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// RunningProcessInfo
#import <JetStream.h>
// Foundation
#import <Foundation/Foundation.h>


@interface JetMemoryStream : NSObject<JetStream>

- (id) initWithData: (NSData*) data;

@end
