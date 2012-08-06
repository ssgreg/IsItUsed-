//
//  FilteredListModel.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "UsedFileFilter.h"
// Foundation
#import <Foundation/Foundation.h>


//
// FilteredListModel
//

@interface FilteredListModel : NSObject
{
  @private
    UsedFileFilter* usedFileFilter;
}

// interface
- (id) initWithFilter:(UsedFileFilter*)filter;
- (NSInteger) count;
- (id) objectAtIndex:(NSInteger) index;

@end
