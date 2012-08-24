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
- (pid_t) pid;
- (bool) isApplication;

@end		


//
// GroupInfo
//

@interface GroupInfo : NSObject

// interface

- (bool) isApplicationGroup;

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
