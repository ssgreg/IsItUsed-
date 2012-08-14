//
//  UsedObjectsTableViewController.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 8/7/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "Models/UsedObjectListModel.h"
// Foundation
#import <Foundation/Foundation.h>


//
// UsedObjectImageTextCell
//

@interface UsedObjectImageTextCell : NSTextFieldCell
{
@private
  NSImageCell* theImageCell;
}

// interface

- (NSImage *)image;
- (void)setImage:(NSImage *)image;

@end


//
// UsedObjectTableViewController
//

@interface UsedObjectTableViewController : NSObject<NSOutlineViewDataSource, NSOutlineViewDelegate, SimpleUpdateProtocol>
{
@private
  IBOutlet NSOutlineView* theOutlineView;
  UsedObjectListModel* theModel;
  NSMutableArray* theBuffer;
}

// interface

- (void) setModel:(UsedObjectListModel*) model;

@end
