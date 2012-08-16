//
//  AppDelegate.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "Models/IsItUsedModel.h"
#import "Controllers/MainWindowController.h"
// Cocoa
#import <Cocoa/Cocoa.h>


//
// AppDelegate
//
@interface AppDelegate : NSObject <NSApplicationDelegate>

// actions

- (IBAction) OnFind:(id)sender;

@end
