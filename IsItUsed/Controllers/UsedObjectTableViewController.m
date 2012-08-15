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
// UsedObjectImageTextCell
//

@implementation UsedObjectImageTextCell

- (id) copyWithZone:(NSZone*) zone
{
  UsedObjectImageTextCell* result = [super copyWithZone: zone];
  if (result)
  {
    result->theImageCell = [theImageCell copyWithZone: zone];
  }
  return result;
}

- (NSImage*) image
{
  return theImageCell.image;
}

- (void) setImage:(NSImage*) image
{
  if (!theImageCell)
  {
    theImageCell = [[NSImageCell alloc] init];
    [theImageCell setControlView: self.controlView];
    [theImageCell setBackgroundStyle: self.backgroundStyle];
  }
  theImageCell.image = image;
}

- (void) setControlView:(NSView*) controlView
{
  [super setControlView: controlView];
  [theImageCell setControlView: controlView];
}

- (void) setBackgroundStyle:(NSBackgroundStyle) style
{
  [super setBackgroundStyle: style];
  [theImageCell setBackgroundStyle: style];
}

- (void) drawInteriorWithFrame:(NSRect) frame inView:(NSView*) controlView
{
  if (theImageCell)
  {
    NSRect imageFrame = [self imageFrame: frame];
    [theImageCell drawWithFrame: imageFrame inView: controlView];
  }
  NSRect titleFrame = [self titleFrame: frame];
  [super drawInteriorWithFrame:titleFrame inView:controlView];
}

- (NSUInteger) hitTestForEvent:(NSEvent*) event inRect:(NSRect) frame ofView:(NSView *) controlView
{
  NSPoint point = [controlView convertPoint: [event locationInWindow] fromView: nil];
  
  // delegate hit testing to sub cells
  if (theImageCell)
  {
    NSRect imageFrame = [self imageFrame: frame];
    if (NSPointInRect(point, imageFrame))
    {
      return [theImageCell hitTestForEvent: event inRect: imageFrame ofView: controlView];
    }
  }
  NSRect titleFrame = [self titleFrame: frame];
  if (NSPointInRect(point, titleFrame))
  {
    return [super hitTestForEvent: event inRect: titleFrame ofView: controlView];
  }
  return NSCellHitNone;
}

- (void) selectWithFrame:(NSRect) aRect inView:(NSView*) controlView editor:(NSText*) textObj delegate:(id) anObject start:(NSInteger) selStart length:(NSInteger) selLength
{
  aRect = [self titleFrame: aRect];
  [super selectWithFrame: aRect inView: controlView editor: textObj delegate: anObject start: selStart length: selLength];
}


- (NSRect) imageFrame:(NSRect) frame
{
  NSInteger const leftPadding = 8;
  //
  NSRect result = frame;
  // max width is height
  result.size.width = result.size.height;
  //
  result.origin.x += leftPadding;
  return result;
}

- (NSRect) titleFrame:(NSRect) frame
{
  NSInteger const leftPadding = 4;
  //
  NSRect imageFrame = [self imageFrame: frame];
  NSRect result = frame;
  // title just after image
  result.origin.x = NSMaxX(imageFrame) + leftPadding;
  result.size.width = NSMaxX(frame) - NSMinX(result);
  return result;
}

@end


//
// UsedObjectCell
//

@implementation UsedObjectCell

@end


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
  //
  theModel.delegate = self;
  [self update];
}

// NSOutlineViewDataSource interface

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

// NSOutlineViewDelegate interface

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
  NSString* identifier = [tableColumn identifier];
  if ([identifier isEqualToString: @"applicationName"])
  {
    if ([item isKindOfClass: [ProcessInfo class]])
    {
      UsedObjectImageTextCell* customCell = cell;
      //
      customCell.stringValue = [item name];
      customCell.image = [item icon];
      if (customCell.image == nil)
      {
        customCell.image = [NSImage imageNamed: @"NSApplicationIcon"];
      }
    }
    else if ([item isKindOfClass: [UsedObjectInfo class]])
    {
      UsedObjectCell* customCell = cell;
      customCell.stringValue = [item path];
    }
  }
}

- (NSCell *)outlineView:(NSOutlineView*) outlineView dataCellForTableColumn:(NSTableColumn*) tableColumn item:(id) item
{
  if (tableColumn != nil)
  {
    if ([item isKindOfClass: [ProcessInfo class]])
    {
      return [tableColumn dataCell];
    }
    else if ([item isKindOfClass: [UsedObjectInfo class]])
    {
      return theUsedObjectCell;
    }
  }
  return nil;
}

// SimpleUpdateDelegate interface

- (void) update
{
  [theBuffer removeAllObjects];
  [theOutlineView reloadData];
}

@end
