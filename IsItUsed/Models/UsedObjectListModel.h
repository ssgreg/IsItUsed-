//
//  UsedObjectsTableViewModel.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 8/6/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "Data/UsedFileFilter.h"
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
// UsedObjectInfo
//

@interface UsedObjectInfo : NSObject
{
@private
  UsedObject* theUsedObject;
}

// interface

- (id) initWithUsedObject:(UsedObject*) usedObject;
- (NSString*) path;
- (NSString*) name;

@end


//
// ProcessInfo
//

@interface ProcessInfo : NSObject
{
@private
  ProcessWithUsedObjects* theProcess;
}

// interface

- (id) initProcessWithUsedObjects:(ProcessWithUsedObjects*) processWithUsedObjects;
- (NSInteger) usedObjectInfoCount;
- (UsedObjectInfo*) usedObjectAtIndex:(NSInteger) index;
- (NSString*) name;
- (NSImage*) icon;

@end		


//
// UsedFilesTableViewModel
//

@interface UsedObjectListModel : NSObject
{
@private
  UsedFileFilter* usedObjectFilter;
  __weak id<SimpleUpdateProtocol> delegate;
}

// interface

- (id) initWithObjectFilter:(UsedFileFilter*) filter;
- (NSInteger) processInfoCount;
- (ProcessInfo*) processInfoAtIndex:(NSInteger) index;
- (void) update;

// properties

@property (weak) id <SimpleUpdateProtocol> delegate;

@end
