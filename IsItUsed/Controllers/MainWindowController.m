//
//  MainWindowController.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/30/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "MainWindowController.h"


//
// MainWindowController
//

@implementation MainWindowController
{
@private
  IBOutlet UsedObjectTableViewController* usedObjectTableViewController;
  IBOutlet NSSearchField* searchField;
  IBOutlet NSButton* myButton;
  IsItUsedModel *appModel;
}

// interface

- (id) init
{
  if (self = [super initWithWindowNibName: @"MainWindow"])
  {
    // force creation of all IB outlets (used in setModel)
    [self window];
    [self makeSearchFieldFirstResponder];


    NSAttributedString* attrString = [myButton attributedAlternateTitle];
//    NSDictionary* dict = [attrString attributesAtIndex:0 effectiveRange: nil];

    CGFloat color =  95 / 255.0f;

    NSColor *txtColor = [NSColor colorWithSRGBRed: color green: color blue: color alpha: 1];
    NSFont *txtFont = [NSFont systemFontOfSize:[NSFont smallSystemFontSize]];

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment: NSLeftTextAlignment];
    [style setFirstLineHeadIndent: 20];
    [style setTailIndent: 100];
    [style setLineBreakMode: NSLineBreakByClipping];

    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
      txtColor, NSForegroundColorAttributeName,
      txtFont, NSFontAttributeName,
      style, NSParagraphStyleAttributeName,
      nil];


//    NSDictionary* dict = [[NSDictionary alloc] init];
    NSMutableAttributedString* string = [[NSMutableAttributedString alloc] initWithString: @"test test test test test test test test test test test greg greg greg greg greg greg greg greg greg greg greg greg" attributes: attrsDictionary];
//    [string addAttribute: NSForegroundColorAttributeName value: [NSColor redColor] range: NSMakeRange(1, 1)];




//    [string setAttributes:<#(NSDictionary *)attrs#> range:<#(NSRange)range#>]

//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    [style setAlignment: NSLeftTextAlignment];

//    NSColor *txtColor = [NSColor redColor];
//    NSFont *txtFont = [NSFont boldSystemFontOfSize:14];

//    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys: [NSColor blackColor], NSForegroundColorAttributeName, nil];
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString: @"0 Characters" attributes: attrsDictionary];



//    [myButton setAttributedTitle: string];
  }
  return self;
}

- (void) setModel:(IsItUsedModel*) newModel
{
  NSAssert(newModel, @"Passed model is empty!");
  NSAssert(usedObjectTableViewController, @"Controller does not initialized from XIB!");
  //
  appModel = newModel;
  // controllers
  [usedObjectTableViewController setModel: [appModel usedObjectListModel]];
}

// actions

- (IBAction) pushMeClicked:(id)sender
{
}

- (IBAction) searchTextChanged:(id) sender
{
  [appModel setFilterText: [sender stringValue]];
}

- (IBAction) findRequested:(id)sender
{
  [self makeSearchFieldFirstResponder];
}

// private

- (void) makeSearchFieldFirstResponder
{
  [searchField becomeFirstResponder];
}

@end
