//
//  UsedObjectsTableViewModel.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 8/6/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "Core/UsedObject.h"
#import "Core/ProcessWithUsedObjects.h"
// Foundation
#import <Foundation/Foundation.h>


//
// SimpleUpdateProtocol
//

@protocol SimpleUpdateProtocol <NSObject>

// interface

- (void) update;

@end


//
// FilterProtocol
//

@protocol FilterProtocol <NSObject>

// interface

- (bool) filter:(id) object;
- (bool) isEmpty;

@end


//
// FilterFacade
//

@interface FilterFacade : NSObject<FilterProtocol>

// interface

- (id) initWithFilterProtocol:(id<FilterProtocol>) filter;

@end


//
// UsedObjectInfo
//

@interface UsedObjectInfo : NSObject

// interface

- (id) initWithUsedObject:(UsedObject*) usedObject;
- (NSString*) path;
- (NSString*) name;

@end


//
// ProcessInfo
//

@interface ProcessInfo : NSObject

// interface

- (id) initProcessWithUsedObjects:(ProcessWithUsedObjects*) processWithUsedObjects filter:(id<FilterProtocol>) filter;
- (NSInteger) usedObjectInfoCount;
- (UsedObjectInfo*) usedObjectAtIndex:(NSInteger) index;

- (NSString*) name;
- (NSImage*) icon;

@end		


//
// UsedFilesTableViewModel
//

@interface UsedObjectListModel : NSObject

// interface

- (id) init;
- (NSInteger) processInfoCount;
- (ProcessInfo*) processInfoAtIndex:(NSInteger) index;
- (void) setFilter:(id<FilterProtocol>) filter;
- (bool) isFilterEmpty;

// properties

@property (weak) id <SimpleUpdateProtocol> delegate;

@end
