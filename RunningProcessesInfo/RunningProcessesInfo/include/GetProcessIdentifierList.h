//
//  GetProcessIdentifierList.h
//
//  Created by Grigory Zubankov on 9/12/12
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// Foundation
#import <Foundation/Foundation.h>


//
// JetGetProcessIdentifierList
//

NSArray* JetGetProcessIdentifierList();


//
// JetPidGetterProtocol
//

@protocol JetPidGetterProtocol <NSObject>

// interface

- (int) copyPidsToBuffer:(void*) buffer size:(int) size;

@end


//
// JetGetPidListInternal
//

NSArray* JetGetPidListInternal(id<JetPidGetterProtocol> pidGetter);
