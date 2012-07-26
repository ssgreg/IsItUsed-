//
//  FilteredListModel.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "FilteredListModel.h"
#import "UsedFile.h"


//
// FilteredListModel
//

@implementation FilteredListModel

- (id)init
{
  self = [super init];
  if (self)
  {
    NSMutableArray* dataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 1000; ++i)
    {
      [dataArray addObject:[[UsedFile alloc] init]];
    }
    
    usedFileFilter = [[UsedFileFilter alloc] init: dataArray];
  }
  return self;
}

- (NSInteger)count
{
  return [[usedFileFilter filteredFiles] count];
}

- (id)objectAtIndex:(NSInteger) index
{
  return [[usedFileFilter filteredFiles] objectAtIndex: index];
}

@end
