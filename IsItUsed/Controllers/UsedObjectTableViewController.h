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

// interface

- (NSImage *)image;
- (void)setImage:(NSImage *)image;

@end


//
// UsedObjectCell
//

@interface UsedObjectCell : NSTextFieldCell
@end


//
// UsedObjectTableViewController
//

@interface UsedObjectTableViewController : NSObject<NSOutlineViewDataSource, NSOutlineViewDelegate, SimpleUpdateProtocol>

// interface

- (void) setModel:(UsedObjectListModel*) model;

@end
