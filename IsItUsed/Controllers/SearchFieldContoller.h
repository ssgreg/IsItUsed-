//
//  SearchFieldContoller.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "../Data/SearchFieldModel.h"
// Foundation
#import <Foundation/Foundation.h>


//
// SearchFieldController
//

@interface SearchFieldContoller : NSObject
{
@private
  SearchFieldModel* model;
  IBOutlet NSSearchField* searchField;
}

// interface
- (void) setModel:(SearchFieldModel*) model;

// actions
- (IBAction) searchTextChanged:(id) sender;

@end
