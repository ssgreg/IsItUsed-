//
//  MainWindowController.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/30/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "MainWindowController.h"
#import "IUQuitProcessAlertWindowController.h"
#import "Controls/StatusBar.h"


//
// MainWindowController
//

@implementation MainWindowController
{
@private
  IBOutlet UsedObjectTableViewController* usedObjectTableViewController;
  IBOutlet NSSearchField* searchField;
  IBOutlet StatusBar* theStatusBar;
  IsItUsedModel *appModel;
  IUQuitProcessAlertWindowController* quitProcessAlertWindowController;
}

// interface

- (id) init
{
  if (self = [super initWithWindowNibName: @"MainWindow"])
  {
    // force creation of all IB outlets (used in setModel)
    [self window];
    [self makeSearchFieldFirstResponder];
    quitProcessAlertWindowController = [[IUQuitProcessAlertWindowController alloc] init];
  }
  return self;
}

- (void) setModel:(IsItUsedModel*) newModel
{
  NSAssert(newModel, @"Passed model is empty!");
  NSAssert(usedObjectTableViewController, @"Controller does not initialized from XIB!");
  //
  appModel = newModel;
  // controllers
  [usedObjectTableViewController setModel: [appModel usedObjectListModel]];
  // self
  [self updateStatusBar];
}

// actions

- (IBAction) QuitProcessClicked:(id) sender
{
  [NSApp beginSheet: quitProcessAlertWindowController.window modalForWindow: [self window] modalDelegate: self didEndSelector: nil contextInfo: nil];
 // [appModel terminateSelectedProcess];
}

- (IBAction) GotoProcessClicked:(id) sender
{
  [appModel activateSelectedProcess];
}

- (IBAction) searchTextChanged:(id) sender
{
  [appModel setFilterText: [sender stringValue]];
  [self updateStatusBar];
}

- (void) findCommandRequested
{
  [self makeSearchFieldFirstResponder];
}

// private

- (void) makeSearchFieldFirstResponder
{
  [searchField becomeFirstResponder];
}

- (void) updateStatusBar
{
  [theStatusBar setTitle: [NSString stringWithFormat: @"Number of processes found: %ld", [appModel processCount]]];
}

@end
