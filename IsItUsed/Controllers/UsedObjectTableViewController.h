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
// UsedObjectTableViewController
//

@interface UsedObjectTableViewController : NSObject<NSTableViewDataSource, NSTableViewDelegate>
{
@private
  IBOutlet NSTableView* theTableView;
  UsedObjectListModel* theModel;
}

// interface

- (void) setModel:(UsedObjectListModel*) model;

@end
