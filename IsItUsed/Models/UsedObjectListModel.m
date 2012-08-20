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
#import "Core/GetProcessWithUsedObjects.h"


//
// UsedObjectInfo
//

@implementation UsedObjectInfo
{
@private
  UsedObject* theUsedObject;
}

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
{
@private
  ProcessWithUsedObjects* theProcess;
  NSArray* theFilteredUsedObjects;
}

// interface

- (id) initProcessWithUsedObjects:(ProcessWithUsedObjects*) processWithUsedObjects filter:(id<FilterProtocol>) filter
{
  if (self = [super init])
  {
    theProcess = processWithUsedObjects;
    [self updateIndexes: filter];

  }
  return self;
}

- (NSInteger) usedObjectInfoCount
{
  return [theFilteredUsedObjects count];
}

- (UsedObjectInfo*) usedObjectAtIndex:(NSInteger) index
{
  return [theFilteredUsedObjects objectAtIndex: index];
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

// private

- (void) updateIndexes:(id<FilterProtocol>) filter
{
  NSMutableArray* filteredUsedObjects = [[NSMutableArray alloc] init];
  NSArray* allUsedObjects = [theProcess usedObjects];
  //
  for (NSInteger i = 0; i < [allUsedObjects count]; ++i)
  {
    UsedObject* usedObject = [allUsedObjects objectAtIndex: i];
    UsedObjectInfo* usedObjectInfo = [[UsedObjectInfo alloc] initWithUsedObject: usedObject];
    if (![filter filter: [usedObjectInfo name]])
    {
      [filteredUsedObjects addObject: usedObjectInfo];
    }
  }
  theFilteredUsedObjects = filteredUsedObjects;
}

@end


//
// UsedObjectListModel
//

@implementation UsedObjectListModel
{
@private
  NSArray* theAllProcesses;
  NSArray* theFilteredProcesses;
  id<FilterProtocol> theFilter;
  __weak id<SimpleUpdateProtocol> delegate;
}

// interface

- (id) init
{
  if (self = [super init])
  {
    theAllProcesses = GetProcessWithUsedObjects();
    [self setFilter: nil];
  }
  return self;
}

- (NSInteger) processInfoCount
{
  return [theFilteredProcesses count];
}

- (ProcessInfo*) processInfoAtIndex:(NSInteger) index
{
  ProcessInfo* processInfo = [theFilteredProcesses objectAtIndex: index];
  return processInfo;
}

- (void) setFilter:(id<FilterProtocol>) filter
{
  theFilter = filter;
  [self updateIndexs];
  [delegate update];
}

- (bool) isFilterEmpty
{
  return theFilter == nil || [theFilter isEmpty];
}

// private interface

- (void) updateIndexs
{
  NSMutableArray* filteredProcesses = [[NSMutableArray alloc] init];
  //
  for (NSInteger i = 0; i < [theAllProcesses count]; ++i)
  {
    ProcessWithUsedObjects* process = [theAllProcesses objectAtIndex: i];
    ProcessInfo* processInfo = [[ProcessInfo alloc] initProcessWithUsedObjects: process filter: theFilter];
    
    // process has filtered objects
    if ([processInfo usedObjectInfoCount])
    {
      [filteredProcesses addObject: processInfo];
    }
    // process filtered by name
    else if (![theFilter filter: [processInfo name]])
    {
      [filteredProcesses addObject: processInfo];
    }
  }
  theFilteredProcesses = filteredProcesses;
}

// properties

@synthesize delegate;

@end
