//
//  AppDelegate.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "AppDelegate.h"


//
// AppDelegate
//

@implementation AppDelegate
{
@private
  IsItUsedModel *appModel;
  MainWindowController *mainWindowController;
}

- (id) init
{
  self = [super init];
  if (self)
  {
    // primary application model
    appModel = [[IsItUsedModel alloc] init];
    // controllers
    mainWindowController = [[MainWindowController alloc] init];
    [mainWindowController setModel: appModel];
  }
  return self;
}

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // make main window active
  [[mainWindowController window] makeKeyAndOrderFront: mainWindowController];
}

// actions

- (IBAction) OnFind:(id)sender
{
  return [mainWindowController findCommandRequested];
}

@end
