//
//  SearchFieldContoller.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "SearchFieldContoller.h"


//
// SearchFieldController
//
@implementation SearchFieldContoller

- (void)setModel:(SearchFieldModel*) newModel;
{
  model = newModel;
}

- (IBAction)searchTextChanged:(id)sender
{
  [model setSearchText:[sender stringValue]];
}

@end
