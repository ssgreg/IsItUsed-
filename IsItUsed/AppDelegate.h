//
//  AppDelegate.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "Data/IsItUsedModel.h"
// Cocoa
#import <Cocoa/Cocoa.h>


//
// AppDelegate
//
@interface AppDelegate : NSObject <NSApplicationDelegate>
{
  @private
    IBOutlet NSSearchField* searchField;
    IsItUsedModel* appModel;
}

@property (assign) IBOutlet NSWindow *window;

@end
