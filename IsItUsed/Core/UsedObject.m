//
//  UsedObject.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/27/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "UsedObject.h"


//
// UsedObject
//

@implementation UsedObject

// interface

- (id) initWithPath: (NSString*) newPath
{
  if (!(self = [super init]))
  {
    return 0;
  }
  name = newPath;
  path = newPath; 
  return self;
}

// properties

@synthesize name;
@synthesize path;


@end
