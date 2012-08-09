//
//  UsedObjectsTableViewModel.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 8/6/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "UsedObjectListModel.h"
#import "Core/ProcessWithUsedObjects.h"


//
// UsedObjectInfo
//

@implementation UsedObjectInfo

// interface

- (id) initWithUsedObject:(UsedObject*) usedObject;
{
  if (self = [super init])
  {
    theUsedObject = usedObject;
  }
  return self;
}

- (NSString*) path
{
  return [theUsedObject path];
}

- (NSString*) name
{
  NSString* path = [theUsedObject path];
  NSRange range = [path rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"/"] options: NSBackwardsSearch];
  return [path substringFromIndex: range.location + 1];
}

@end


//
// ProcessInfo
//

@implementation ProcessInfo

// interface

- (id) initProcessWithUsedObjects:(ProcessWithUsedObjects*) processWithUsedObjects
{
  if (self = [super init])
  {
    theProcess = processWithUsedObjects;
  }
  return self;
}

- (NSInteger) usedObjectInfoCount
{
  return [[theProcess usedObjects] count];
}

- (UsedObjectInfo*) usedObjectAtIndex:(NSInteger) index
{
  return [[UsedObjectInfo alloc] initWithUsedObject: [[theProcess usedObjects] objectAtIndex: index]];
}

- (NSString*) name
{
  NSString* appName = [theProcess appName];
  if (appName == nil)
  {
    appName = [theProcess name];
  }
  return appName;
}

- (NSImage*) icon
{
  return [theProcess appIcon];
}

@end


//
// UsedObjectListModel
//

@implementation UsedObjectListModel

// interface

- (id) initWithObjectFilter:(UsedFileFilter*) newFilter
{
  if (self = [super init])
  {
    usedObjectFilter = newFilter;
  }
  return self;
}

- (NSInteger) processInfoCount
{
  return [[usedObjectFilter filteredFiles] count];
}

- (ProcessInfo*) processInfoAtIndex:(NSInteger) index
{
  ProcessWithUsedObjects* process = [[usedObjectFilter filteredFiles] objectAtIndex: index];
  ProcessInfo* processInfo = [[ProcessInfo alloc] initProcessWithUsedObjects: process];
  return processInfo;
}

@end
