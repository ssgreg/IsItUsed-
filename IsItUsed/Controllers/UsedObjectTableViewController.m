//
//  UsedObjectsTableViewController.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 8/7/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "UsedObjectTableViewController.h"


//
// UsedObjectsTableViewController
//

@implementation UsedObjectTableViewController

// interface

- (void) setModel:(UsedObjectListModel*) model
{
  NSAssert(model, @"Passed model is empty!");
  //
  theModel = model;
  [theTableView reloadData];
}

// NSTableViewDataSource interface

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
  return [theModel count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
  NSString* identifier = [tableColumn identifier];
  NSTableCellView* cellView = [tableView makeViewWithIdentifier: identifier owner: self];
  if (!cellView)
  {
    NSAssert1(NO, @"Unhandled table column identifier %@", identifier);
  }

  UsedObjectInfo* objectInfo = [theModel objectAtIndex: row];
  
  if ([identifier isEqualToString: @"applicationName"])
  {
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    // Then setup properties on the cellView based on the column
    cellView.textField.stringValue = [objectInfo applicationName];
    
//    NSImage* temp = [[NSRunningApplication runningApplicationWithProcessIdentifier: 2323] icon];
//    cellView.imageView.objectValue = temp;
    return cellView;

  } else if ([identifier isEqualToString: @"usedObjectPath"])
  {
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    // Then setup properties on the cellView based on the column
    cellView.textField.stringValue = @"1";
    //    cellView.imageView.objectValue = [dictionary objectForKey:@"Image"];
    return cellView;
  }
  return cellView;
}

@end
