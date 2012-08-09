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
  theBuffer = [NSMutableArray array];
  [theOutlineView reloadData];
}

- (NSInteger) outlineView:(NSOutlineView*) outlineView numberOfChildrenOfItem:(id) item
{
  if (item == nil)
  {
    return [theModel processInfoCount];
  }
  else if ([item isKindOfClass: [ProcessInfo class]])
  {
    return [item usedObjectInfoCount];
  }
  NSAssert(NO, @"Passed unknown item!");
  return 0;
}

- (id) outlineView:(NSOutlineView*) outlineView child:(NSInteger) index ofItem:(id) item
{
  if (item == nil)
  {
    id object = [theModel processInfoAtIndex: index];
    [theBuffer addObject: object];
    return object;
  }
  else if ([item isKindOfClass: [ProcessInfo class]])
  {
    id object = [item usedObjectAtIndex: index];
    [theBuffer addObject: object];
    return object;
  }
//  else if ([item isKindOfClass: [ProcessInfo class]])
//  {
//    return
//  }
  NSAssert(NO, @"Passed unknown item!");
  return nil;
}

- (BOOL) outlineView:(NSOutlineView*) outlineView isItemExpandable:(id) item
{
  if ([item isKindOfClass: [ProcessInfo class]])
  {
    return true;
  }
  return false;
}

//- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
//{
//  
//}

//- (id) outlineView:(NSOutlineView*) outlineView objectValueForTableColumn:(NSTableColumn*) tableColumn byItem:(id) item
//{
//  return item;
//}

- (NSView*) outlineView:(NSOutlineView*) outlineView viewForTableColumn:(NSTableColumn*) tableColumn item:(id) item
{
  NSString* identifier = [tableColumn identifier];
  if ([identifier isEqualToString: @"applicationName"])
  {
    NSTableCellView *cellView = [outlineView makeViewWithIdentifier: identifier owner: self];
    //
    if ([item isKindOfClass: [ProcessInfo class]])
    {
      cellView.textField.stringValue = [item name];
      NSImage* image =[item icon];
      cellView.imageView.objectValue = [item icon];
    }
    else if ([item isKindOfClass: [UsedObjectInfo class]])
    {
      cellView.textField.stringValue = [item name];
      cellView.imageView.objectValue = nil;
    }
    return cellView;
  }
  else if ([identifier isEqualToString: @"usedObjectPath"])
  {
    NSTableCellView *cellView = [outlineView makeViewWithIdentifier: identifier owner: self];
    cellView.textField.stringValue = @"test";
    ////    NSImage* temp = [[NSRunningApplication runningApplicationWithProcessIdentifier: 2323] icon];
    ////    cellView.imageView.objectValue = temp;
    return cellView;
  }
  return nil;
}    


//// NSTableViewDataSource interface
//
//- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
//{
//  return [theModel count];
//}
//
//- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
//{
//  NSString* identifier = [tableColumn identifier];
//  NSTableCellView* cellView = [tableView makeViewWithIdentifier: identifier owner: self];
//  if (!cellView)
//  {
//    NSAssert1(NO, @"Unhandled table column identifier %@", identifier);
//  }
//
//  UsedObjectInfo* objectInfo = [theModel objectAtIndex: row];
//  
//  if ([identifier isEqualToString: @"applicationName"])
//  {
//    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
//    // Then setup properties on the cellView based on the column
//    cellView.textField.stringValue = [objectInfo applicationName];
//    
////    NSImage* temp = [[NSRunningApplication runningApplicationWithProcessIdentifier: 2323] icon];
////    cellView.imageView.objectValue = temp;
//    return cellView;
//
//  } else if ([identifier isEqualToString: @"usedObjectPath"])
//  {
//    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
//    // Then setup properties on the cellView based on the column
//    cellView.textField.stringValue = @"1";
//    //    cellView.imageView.objectValue = [dictionary objectForKey:@"Image"];
//    return cellView;
//  }
//  return cellView;
//}

@end
