//
//  IsItUsedModel.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "IsItUsedModel.h"

//
// IsItUsedModel
//

@implementation IsItUsedModel

- (id)init
{
  self = [super init];
  if (self)
  {
    // create intrusive models
    filteredListModel = [[FilteredListModel alloc] init];
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
