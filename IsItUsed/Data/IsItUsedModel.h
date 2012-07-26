//
//  IsItUsedModel.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "FilteredListModel.h"
#import "SearchFieldModel.h"
// Foundation
#import <Foundation/Foundation.h>


//
// IsItUsedModel
//
@interface IsItUsedModel : NSObject
{
  @private
    FilteredListModel* filteredListModel;
    SearchFieldModel* searchFieldModel;
}

- (FilteredListModel*)filteredListModel;
- (SearchFieldModel*)searchFieldModel;

@end
