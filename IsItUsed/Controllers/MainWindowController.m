//
//  MainWindowController.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/30/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "MainWindowController.h"


//
// MainWindowController
//

@implementation MainWindowController

// interface

- (id) init
{
  if (self = [super initWithWindowNibName: @"MainWindow"])
  {
    // force creation of all IB outlets (used in setModel)
    [self window];
    [self makeSearchFieldFirstResponder];
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
}

// actions

- (IBAction) pushMeClicked:(id)sender
{
}

- (IBAction) searchTextChanged:(id) sender
{
  [appModel setFilterText: [sender stringValue]];
}

- (IBAction) findRequested:(id)sender
{
  [self makeSearchFieldFirstResponder];
}

// private

- (void) makeSearchFieldFirstResponder
{
  [searchField becomeFirstResponder];
}

@end
	