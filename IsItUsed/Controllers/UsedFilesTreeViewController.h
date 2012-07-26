//
//  UsedFilesTreeViewController.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Data/UsedFileFilter.h"


//
// UsedFilesTreeViewController
//
@interface UsedFilesTreeViewController : NSObject<NSTableViewDataSource>
{
  @private
    IBOutlet NSTableView* TheTableView;
    UsedFileFilter* usedFileArray;
}

- (IBAction)SetFilter:(id)sender;

@end
