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

- (id)init
{
  if (self = [super init])
  {
    // create domain model data
    usedFileFilter = [[UsedFileFilter alloc] init: GetProcessWithUsedObjects()];
    // create intrusive models
    filteredListModel = [[FilteredListModel alloc] initWithFilter: usedFileFilter];
    searchFieldModel = [[SearchFieldModel alloc] init];
  }
  return self;
}

- (FilteredListModel*)filteredListModel
{
  return filteredListModel;
}

- (SearchFieldModel*)searchFieldModel
{
  return searchFieldModel;
}

@end
