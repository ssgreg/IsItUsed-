//
//  UsedFileFilter.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "UsedFileFilter.h"
#import "../Data/UsedFile.h"


//
// UsedFileFilter
//

@implementation UsedFileFilter

@synthesize filteredFiles;

- (id)init:(NSMutableArray*) usedFiles
{
  self = [super init];
  if (self)
  {
    allFiles = usedFiles;
    filteredFiles = allFiles;
  }
  return self;
}

- (void)setFilter:(NSString*) newFilter
{
  filter = newFilter;
  filteredFiles = [[NSMutableArray alloc] initWithArray:allFiles];
  
  // remove filtered items
  NSMutableIndexSet* discardedItems = [NSMutableIndexSet indexSet];
  for (int i = 0; i < [filteredFiles count]; ++i)
  {
    NSRange range = [[[filteredFiles objectAtIndex:i] usedFile] rangeOfString:filter];
    if (range.location != NSNotFound)
    {
      [discardedItems addIndex:i];
    }
  }
  [filteredFiles removeObjectsAtIndexes:discardedItems];
}

@end
