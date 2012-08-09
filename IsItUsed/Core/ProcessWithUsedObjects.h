//
//  ProcessWithUsedObjects.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/27/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// Foundation
#import <Foundation/Foundation.h>


//
// ProcessWithUsedObjects
//
@interface ProcessWithUsedObjects : NSObject
{
@private
  NSString* name;
  pid_t pid;
  NSString* appName;
  NSImage* appIcon;
  NSMutableArray* usedObjects;
}

// interface

- (id) initWithName: (NSString*) name pid: (pid_t) pid usedObjects: (NSMutableArray*) usedObjects;

- (void) activate;
- (void) terminate;

// properties

@property (readonly) NSString* name;
@property (readonly) pid_t pid;
@property (readonly) NSString* appName;
@property (readonly) NSImage* appIcon;
@property (readonly) NSMutableArray* usedObjects;

@end
