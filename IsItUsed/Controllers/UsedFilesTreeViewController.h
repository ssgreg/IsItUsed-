//
//  UsedFilesTreeViewController.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "../Data/FilteredListModel.h"
// Foundation
#import <Foundation/Foundation.h>


//
// UsedFilesTreeViewController
//
@interface UsedFilesTreeViewController : NSObject<NSTableViewDataSource>
{
  @private
    IBOutlet NSTableView* TheTableView;
    FilteredListModel* model;
}

- (void)setModel:(FilteredListModel*) model;

@end
