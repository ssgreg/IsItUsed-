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
// Foundation
#import <Foundation/Foundation.h>


//
// UsedObjectInfo
//

@interface UsedObjectInfo : NSObject
{
@private
  NSString* applicationName;
  NSString* usedObjectPath;
}

// interface

- (id) initWithApplicationName:(NSString*) applicationName usedObjectPath:(NSString*) usedObjectPath;

// properties

@property (readonly) NSString* applicationName;
@property (readonly) NSString* usedObjectPath;

@end


//
// UsedFilesTableViewModel
//

@interface UsedObjectListModel : NSObject
{
@private
  UsedFileFilter* usedObjectFilter;
}

// interface

- (id) initWithObjectFilter:(UsedFileFilter*) filter;
- (NSInteger) count;
- (UsedObjectInfo*) objectAtIndex:(NSInteger) index;

@end
