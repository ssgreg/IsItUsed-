//
//  MainWindowController.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/30/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "Data/IsItUsedModel.h"
#import "Controllers/SearchFieldContoller.h"
#import "Controllers/UsedFilesTreeViewController.h"
// Cocoa
#import <Cocoa/Cocoa.h>


@interface MainWindowController : NSWindowController
{
@private
  IBOutlet UsedFilesTreeViewController* usedFilesTreeViewController;
  IBOutlet SearchFieldContoller* searchFieldController;
  IsItUsedModel* appModel;
}

// interface
- (void) setModel:(IsItUsedModel*) model;

@end
