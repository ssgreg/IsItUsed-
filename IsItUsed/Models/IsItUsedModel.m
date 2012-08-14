//
//  IsItUsedModel.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "IsItUsedModel.h"
#import "Core/GetProcessWithUsedObjects.h"


//
// IsItUsedModel
//

@implementation IsItUsedModel

// interface

- (id) init
{
  if (self = [super init])
  {
    // create domain model data
    usedFileFilter = [[UsedFileFilter alloc] init: GetProcessWithUsedObjects()];
    // make models
    usedObjectListModel = [[UsedObjectListModel alloc] initWithObjectFilter: usedFileFilter];
  }
  return self;
}

- (UsedObjectListModel*) usedObjectListModel
{
  return usedObjectListModel;
}

- (void) setFilterText:(NSString*) filterText
{
  [usedFileFilter setFilter: filterText];
  [usedObjectListModel update];
}

@end
