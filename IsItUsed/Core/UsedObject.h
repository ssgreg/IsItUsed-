//
//  UsedObject.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/27/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// Foundation
#import <Foundation/Foundation.h>


//
// UsedObject
//
@interface UsedObject : NSObject
{
@private
  NSString* name;
  NSString* path;
}

// interface

- (id) initWithPath: (NSString*) path;

// properties

@property (readonly) NSString* name;
@property (readonly) NSString* path;

@end
