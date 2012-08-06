//
//  FilteredListModel.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "FilteredListModel.h"


//
// FilteredListModel
//

@implementation FilteredListModel

- (id) initWithFilter:(UsedFileFilter*)filter
{
  NSAssert(filter, @"Filter have to be initialized");
  //
  if (self = [super init])
  {
    usedFileFilter = filter;
  }
  return self;
}

- (NSInteger) count
{
  return [[usedFileFilter filteredFiles] count];
}

- (id) objectAtIndex:(NSInteger) index
{
  return [[usedFileFilter filteredFiles] objectAtIndex: index];
}

@end
