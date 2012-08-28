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

// interface

- (void) setModel:(IsItUsedModel*) model;
- (void) findCommandRequested;

// actions

- (IBAction) QuitProcessClicked:(id)sender;
- (IBAction) GotoProcessClicked:(id)sender;
- (IBAction) searchTextChanged:(id) sender;

@end
