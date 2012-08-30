//
//  IUQuitProcessAlertWindowController.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 8/29/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// Cocoa
#import <Cocoa/Cocoa.h>


//
// IUQuitProcessAlertWindowController
//

@interface IUQuitProcessAlertWindowController : NSWindowController

// actions

- (IBAction) closeClicked:(id) sender;
- (IBAction) quitClicked:(id) sender;
- (IBAction) forceQuitClicked:(id) sender;

@end
