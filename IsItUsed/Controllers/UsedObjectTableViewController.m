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
  
  // delegate hit testing to subcells
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
  NSRect result = frame;
  result.size.width = theImageCell.image.size.width;
  //  // Inset the top
  //  result.origin.y += IMAGE_INSET;
  //  result.size.height -= 2*IMAGE_INSET;
  //  // Inset the left
  //  result.origin.x += IMAGE_INSET;
  //  // Make the width match the aspect ratio based on the height
  //  result.size.width = ceil(result.size.height * ASPECT_RATIO);
  return result;
}

- (NSRect) titleFrame:(NSRect) frame
{
  NSRect imageFrame = [self imageFrame: frame];
  NSRect result = frame;
  result.origin.x += imageFrame.size.width;
  //  // Move our inset to the left of the image frame
  //  result.origin.x = NSMaxX(imageFrame) + INSET_FROM_IMAGE_TO_TEXT;
  //  // Go as wide as we can
  //  result.size.width = NSMaxX(frame) - NSMinX(result);
  //  // Move the title above the Y centerline of the image.
  //  NSSize naturalSize = [super cellSize];
  //  result.origin.y = floor(NSMidY(imageFrame) - naturalSize.height - INSET_FROM_IMAGE_TO_TEXT);
  //  result.size.height = naturalSize.height;
  return result;
}

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

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
  NSTextFieldCell* customCell = cell;
  customCell.stringValue = [item name];
  customCell.image = [item icon];
  
}

//- (id) outlineView:(NSOutlineView*) outlineView objectValueForTableColumn:(NSTableColumn*) tableColumn byItem:(id) item
//{
//  return item;
//}

// NSOutlineViewDelegate interface

//- (NSView*) outlineView:(NSOutlineView*) outlineView viewForTableColumn:(NSTableColumn*) tableColumn item:(id) item
//{
//  NSString* identifier = [tableColumn identifier];
//  if ([identifier isEqualToString: @"applicationName"])
//  {
//    NSTableCellView *cellView = [outlineView makeViewWithIdentifier: identifier owner: self];
//    //
//    if ([item isKindOfClass: [ProcessInfo class]])
//    {
//      cellView.textField.stringValue = [item name];
//      NSImage* image =[item icon];
//      cellView.imageView.objectValue = [item icon];
//    }
//    else if ([item isKindOfClass: [UsedObjectInfo class]])
//    {
//      cellView.textField.stringValue = [item path];
//      cellView.imageView.objectValue = nil;
//    }
//    return cellView;
//  }
//  else if ([identifier isEqualToString: @"usedObjectPath"])
//  {
//    NSTableCellView *cellView = [outlineView makeViewWithIdentifier: identifier owner: self];
//    cellView.textField.stringValue = @"test";
//    ////    NSImage* temp = [[NSRunningApplication runningApplicationWithProcessIdentifier: 2323] icon];
//    ////    cellView.imageView.objectValue = temp;
//    return cellView;
//  }
//  return nil;
//}

// SimpleUpdateDelegate interface

- (void) update
{
  [theBuffer removeAllObjects];
  [theOutlineView reloadData];
  [theOutlineView reloadData];
}

@end
