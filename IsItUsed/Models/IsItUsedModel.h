//
//  IsItUsedModel.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "Models/UsedObjectListModel.h"
// Foundation
#import <Foundation/Foundation.h>


//
// IsItUsedModel
//
@interface IsItUsedModel : NSObject

// interface

// models
- (UsedObjectListModel*) usedObjectListModel;

// manipulators
- (void) setFilterText:(NSString*) filterText;

@end
