
//  UsedFilesTreeViewController.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "UsedFilesTreeViewController.h"
#import "Core/UsedObject.h"


//
// UsedFilesTreeViewController
//

@implementation UsedFilesTreeViewController

- (void) setModel:(FilteredListModel*) newModel
{
  NSAssert(newModel, @"Model have to be initialized");
  //
  model = newModel;
  [TheTableView reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
  return [model count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
  UsedObject* usedFile = [model objectAtIndex:row];
  return [usedFile valueForKey:[tableColumn identifier]];
}

@end
