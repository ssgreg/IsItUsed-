//
//  StatusBar.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 8/17/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "StatusBar.h"


//
// StatusBar
//

@implementation StatusBar

- (void) setTitle:(NSString*) title
{
  // text color
  CGFloat color =  95 / 255.0f;
  NSColor* textColor = [NSColor colorWithSRGBRed: color green: color blue: color alpha: 1];
  // text font
  NSFont* textFont = [NSFont systemFontOfSize:[NSFont smallSystemFontSize]];
  // text style
  NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
  [textStyle setAlignment: NSLeftTextAlignment];
  [textStyle setFirstLineHeadIndent: 8];
  [textStyle setLineBreakMode: NSLineBreakByClipping];
  //
  NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                   textColor, NSForegroundColorAttributeName,
                                   textFont, NSFontAttributeName,
                                   textStyle, NSParagraphStyleAttributeName,
                                   nil];
  //
  [self setAttributedTitle: [[NSMutableAttributedString alloc] initWithString: title attributes: attrsDictionary]];
}

@end
