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

- (id) initWithApplicationName:(NSString*) newApplicationName usedObjectPath:(NSString*) newUsedObjectPath
{
  if (self = [super init])
  {
    applicationName = newApplicationName;
    usedObjectPath = newUsedObjectPath;
  }
  return self;
}

// properties

@synthesize applicationName;
@synthesize usedObjectPath;

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

- (NSInteger) count
{
  return [[usedObjectFilter filteredFiles] count];
}

- (UsedObjectInfo*) objectAtIndex:(NSInteger) index
{
  ProcessWithUsedObjects* process = [[usedObjectFilter filteredFiles] objectAtIndex: index];
  NSString* name = [process appName];
  if (!name)
  {
    name = [process name];
  }
  return [[UsedObjectInfo alloc] initWithApplicationName: name usedObjectPath: @"path"];
//  return NULL; //return [[usedFileFilter filteredFiles] objectAtIndex: index];
}

@end
