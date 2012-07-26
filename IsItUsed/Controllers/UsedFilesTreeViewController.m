//
//  UsedFilesTreeViewController.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "UsedFilesTreeViewController.h"
#import "../Data/UsedFile.h"


@implementation UsedFilesTreeViewController

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
    
    usedFileArray = [[UsedFileFilter alloc] init: dataArray];
  }
  return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
  return [[usedFileArray filteredFiles] count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
  UsedFile* usedFile = [[usedFileArray filteredFiles] objectAtIndex:row];
  NSString* columnID = [tableColumn identifier];
  return [usedFile valueForKey:columnID];
}

- (IBAction)SetFilter:(id)sender
{
  NSString* searchString = [sender stringValue];
  [usedFileArray setFilter:searchString];
  [TheTableView reloadData];
}

@end
