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
  id<FilterProtocol> theFilter;
  ProcessWithUsedObjects* theProcess;
  NSArray* theFilteredUsedObjects;
}

// interface

- (id) initProcessWithUsedObjects:(ProcessWithUsedObjects*) processWithUsedObjects filter:(id<FilterProtocol>) filter
{
  if (self = [super init])
  {
    theFilter = filter;
    theProcess = processWithUsedObjects;
    [self updateIndexes];

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
  
  return [NSString stringWithFormat: @"%@ - %d", appName, [theProcess pid]];
  return appName;
}

- (NSImage*) icon
{
  return [theProcess appIcon];
}

- (bool) isApplication
{
  return [theProcess appName] != nil;
}

- (pid_t) pid
{
  return [theProcess pid];
}

- (bool) isFiltered
{
  bool isFilteredByProcessName = [theFilter filter: [self name]];
  if (!isFilteredByProcessName)
  {
    return false;
  }
  if ([self usedObjectInfoCount] > 0)
  {
    return false;
  }
  return true;
}

// private

- (bool) isExcluded:(UsedObjectInfo*) usedObjectInfo
{
  NSString* path = [usedObjectInfo path];
  if ([path isEqualToString: @"/"])
  {
    return true;
  }
  NSRange range = [path rangeOfString: @"/dev/" options: NSCaseInsensitiveSearch];
  if (range.location != NSNotFound && range.location == 0)
  {
    return true;
  }
  return false;
}

- (void) updateIndexes
{
  bool isFilteredByProcessName = [theFilter filter: [self name]];
  NSMutableArray* filteredUsedObjects = [[NSMutableArray alloc] init];
  NSArray* allUsedObjects = [theProcess usedObjects];
  //
  for (NSInteger i = 0; i < [allUsedObjects count]; ++i)
  {
    UsedObject* usedObject = [allUsedObjects objectAtIndex: i];
    UsedObjectInfo* usedObjectInfo = [[UsedObjectInfo alloc] initWithUsedObject: usedObject];
    if (!isFilteredByProcessName || ![theFilter filter: [usedObjectInfo name]])
    {
      if (![self isExcluded: usedObjectInfo])
      {
        [filteredUsedObjects addObject: usedObjectInfo];
      }
    }
  }
  theFilteredUsedObjects = filteredUsedObjects;
}

@end


//
// GroupInfo
//

@implementation GroupInfo
{
@private
  bool theApplicationFlag;
}

// interface

- initWithApplicationFlag:(bool) applicationFlag
{
  if (self = [super init])
  {
    theApplicationFlag = applicationFlag;
  }
  return self;
}

- (bool) isApplicationGroup
{
  return theApplicationFlag;
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
  NSArray* theFilteredApplications;
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
  return [theFilteredProcesses count] + [theFilteredApplications count];
}

- (ProcessInfo*) processInfoAtIndex:(NSInteger) index
{
  NSInteger offset = index - [theFilteredApplications count];
  if (offset < 0)
  {
    return [theFilteredApplications objectAtIndex: index];
  }
  else
  {
    return [theFilteredProcesses objectAtIndex: offset];
  }
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

- (void) setSelectedProcessInfo:(ProcessInfo*) item
{
  
}

- (ProcessInfo*) getSelectedProcessInfo
{
  return nil;
}


// private interface

- (void) updateIndexs
{
  NSMutableArray* filteredProcesses = [[NSMutableArray alloc] init];
  NSMutableArray* filteredApplications = [[NSMutableArray alloc] init];
  //
  [filteredApplications addObject: [[GroupInfo alloc] initWithApplicationFlag: true]];
  [filteredProcesses addObject: [[GroupInfo alloc] initWithApplicationFlag: false]];
  //
  for (NSInteger i = 0; i < [theAllProcesses count]; ++i)
  {
    ProcessWithUsedObjects* process = [theAllProcesses objectAtIndex: i];
    ProcessInfo* processInfo = [[ProcessInfo alloc] initProcessWithUsedObjects: process filter: theFilter];
    //
    if (![processInfo isFiltered])
    {
      [processInfo isApplication] == YES
        ? [filteredApplications addObject: processInfo]
        : [filteredProcesses addObject: processInfo];
    }
  }
  
  id mySort = ^(ProcessInfo* left, ProcessInfo* right)
  {
    if ([left isKindOfClass: [GroupInfo class]])
    {
      return (NSComparisonResult)NSOrderedAscending;
    }
    return [[left name] caseInsensitiveCompare: [right name]];
  };

  theFilteredProcesses = [filteredProcesses sortedArrayUsingComparator: mySort];
  theFilteredApplications = [filteredApplications sortedArrayUsingComparator: mySort];
}

// properties

@synthesize delegate;

@end
