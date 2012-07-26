//
//  UsedFilesTreeViewController.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Data/FilteredListModel.h"


//
// UsedFilesTreeViewController
//
@interface UsedFilesTreeViewController : NSObject<NSTableViewDataSource>
{
  @private
    IBOutlet NSTableView* TheTableView;
    FilteredListModel* model;
}

- (IBAction)SetFilter:(id)sender;
- (void)setModel:(FilteredListModel*) model;

@end
