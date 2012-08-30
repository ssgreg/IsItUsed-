//
//  IUQuitProcessAlertWindowController.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 8/29/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "IUQuitProcessAlertWindowController.h"
#import "Models/UsedObjectListModel.h"


//
// IUQuitProcessAlertWindowController
//

@implementation IUQuitProcessAlertWindowController
{
@private
  IBOutlet NSImageView* theProcessIconView;
  IBOutlet NSTextField* theHederText;
  IBOutlet NSTextField* theDescriptionText;
}

// interface

- (id) init
{
  if (self = [super initWithWindowNibName: @"QuitProcessAlertWindow"])
  {
    // force creation of all IB outlets
    [self window];
    [theHederText setStringValue  : @"Are you sure you want to quit this process?"];
    [theDescriptionText setStringValue: @"Do you really want to quit @1?"];
  }
  return self;
}

// actions

- (IBAction) closeClicked:(id) sender
{
  [NSApp endSheet: self.window];
  [self.window orderOut: sender];
}

- (IBAction) quitClicked:(id) sender
{
  [self closeClicked: sender];
}

- (IBAction) forceQuitClicked:(id) sender
{
  [self closeClicked: sender];
}

@end
