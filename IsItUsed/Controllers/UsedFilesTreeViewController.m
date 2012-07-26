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
  }
  return self;
}

- (void)setModel:(FilteredListModel*) newModel
{
  model = newModel;
  [TheTableView reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
  return [model count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
  UsedFile* usedFile = [model objectAtIndex:row];
  return [usedFile valueForKey:[tableColumn identifier]];
}

- (IBAction)SetFilter:(id)sender
{
//  NSString* searchString = [sender stringValue];
//  [usedFileArray setFilter:searchString];
  [TheTableView reloadData];
}

@end
