//
//  AppDelegate.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
  @private
    IBOutlet NSSearchField* searchField;
}

@property (assign) IBOutlet NSWindow *window;

@end
