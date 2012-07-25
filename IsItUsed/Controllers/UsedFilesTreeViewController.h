//
//  UsedFilesTreeViewController.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsedFilesTreeViewController : NSObject<NSTableViewDataSource>
{
  @private
    IBOutlet NSTableView* TheTableView;
    NSMutableArray* dataArray;
}

- (IBAction)SetFilter:(id)sender;

@end
