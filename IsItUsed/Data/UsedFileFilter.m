//
//  UsedFileFilter.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "UsedFileFilter.h"
#import "../Core/GetProcessWithUsedObjects.h"


//
// UsedFileFilter
//

@implementation UsedFileFilter

@synthesize filteredFiles;

- (id)init:(NSMutableArray*) usedFiles
{
  if (self = [super init])
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
  
  if ([filter length] == 0)
  {
    return;
  }
  
  // remove filtered items
  NSMutableIndexSet* discardedItems = [NSMutableIndexSet indexSet];
  for (int i = 0; i < [filteredFiles count]; ++i)
  {
    NSRange range = [[[filteredFiles objectAtIndex:i] name] rangeOfString:filter];
    if (range.location == NSNotFound)
    {
      [discardedItems addIndex:i];
    }
  }
  [filteredFiles removeObjectsAtIndexes:discardedItems];
}

@end
