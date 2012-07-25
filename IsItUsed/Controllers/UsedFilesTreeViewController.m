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
    dataArray = [[NSMutableArray alloc] init];
  }
  return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
  return [dataArray count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
  UsedFile* usedFile = [dataArray objectAtIndex:row];
  NSString* columnID = [tableColumn identifier];
  return [usedFile valueForKey:columnID];
}

- (IBAction)SetFilter:(id)sender
{
  [dataArray addObject:[[UsedFile alloc] init]];
  [TheTableView reloadData];
}

@end
