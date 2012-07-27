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

- (id) init
{
  self = [super init];
  if (self)
  {
    // primary application model
    appModel = [[IsItUsedModel alloc] init];
  }
  return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  [usedFilesTreeViewController setModel:[appModel filteredListModel]];
  [searchFieldController setModel:[appModel searchFieldModel]];
  // TODO: View responsibility | Need to move
  [searchField becomeFirstResponder];
}

@end
