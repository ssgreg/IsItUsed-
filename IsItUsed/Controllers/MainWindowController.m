//
//  MainWindowController.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/30/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "MainWindowController.h"


@implementation MainWindowController

- (id) init
{
  if (self = [super initWithWindowNibName: @"MainWindow"])
  {
    // force creation of all IB outlets (used in setModel)
    [self window];
  }
  return self;
}

- (void) setModel:(IsItUsedModel*) newModel
{
  NSAssert(newModel, @"Model have to be initialized");
  NSAssert(usedFilesTreeViewController && searchFieldController, @"Where are my controllers?");
  //
  appModel = newModel;
  // controllers
  [usedFilesTreeViewController setModel: [appModel filteredListModel]];
  [searchFieldController setModel: [appModel searchFieldModel]];
}

- (IBAction)pushMeClicked:(id)sender
{
}

@end
	