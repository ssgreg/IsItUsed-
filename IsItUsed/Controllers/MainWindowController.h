//
//  MainWindowController.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/30/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "Models/IsItUsedModel.h"
#import "Controllers/UsedObjectTableViewController.h"
// Cocoa
#import <Cocoa/Cocoa.h>


//
// MainWindowController
//

@interface MainWindowController : NSWindowController
{
@private
  IBOutlet UsedObjectTableViewController* usedObjectTableViewController;
  IBOutlet NSSearchField* searchField;
  IsItUsedModel* appModel;
}

// interface

- (void) setModel:(IsItUsedModel*) model;

// actions

- (IBAction) pushMeClicked:(id)sender;
- (IBAction) searchTextChanged:(id) sender;
- (IBAction) findRequested:(id)sender;

@end
