//
//  IsItUsedModel.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "IsItUsedModel.h"


//
// TextFilter
//

@interface TextFilter : NSObject<FilterProtocol>

// inteface
- (id) initWithText:(NSString*) text;

@end

@implementation TextFilter
{
@private
  NSString* theText;
}

// inteface

- (id) initWithText:(NSString*) text
{
  if (self = [super init])
  {
    theText = text;
  }
  return self;
}

// FilterProtocol interaface

- (bool) filter:(id)object
{
  if ([self isEmpty])
  {
    return false;
  }
  NSRange range = [object rangeOfString: theText];
  return range.location == NSNotFound;
}

- (bool) isEmpty
{
  return theText == nil || [theText length] == 0;
}

@end


//
// IsItUsedModel
//

@implementation IsItUsedModel
{
@private
  // data
  id<FilterProtocol> theFilter;
  // models
  UsedObjectListModel* usedObjectListModel;
}

// interface

- (id) init
{
  if (self = [super init])
  {
    usedObjectListModel = [[UsedObjectListModel alloc] init];
  }
  return self;
}

- (UsedObjectListModel*) usedObjectListModel
{
  return usedObjectListModel;
}

- (void) setFilterText:(NSString*) filterText
{
  theFilter = [[TextFilter alloc] initWithText: filterText];
  [usedObjectListModel setFilter: theFilter];
}

- (NSInteger) processCount
{
  return [usedObjectListModel processInfoCount];
}

@end
