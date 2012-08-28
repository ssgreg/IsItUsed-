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
- (bool) setText:(NSString*) text;

@end

@implementation TextFilter
{
@private
  NSString* theText;
}

// inteface

- (bool) setText:(NSString*) text
{
  if (text == nil && theText == nil)
  {
    return false;
  }
  if (text != nil && theText != nil)
  {
    if ([theText isEqualToString: text])
    {
      return false;
    }
  }
  theText = text;
  return true;
}

// FilterProtocol interaface

- (bool) filter:(id)object
{
  if ([self isEmpty])
  {
    return false;
  }
  NSRange range = [object rangeOfString: theText options: NSCaseInsensitiveSearch];
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
  TextFilter* theFilter;
  // models
  UsedObjectListModel* usedObjectListModel;
}

// interface

- (id) init
{
  if (self = [super init])
  {
    theFilter = [[TextFilter alloc] init];
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
  if ([theFilter setText: filterText])
  {
    [usedObjectListModel setFilter: theFilter];
  }
}

- (void) activateSelectedProcess
{
  [[NSRunningApplication runningApplicationWithProcessIdentifier:9003] activateWithOptions:NSApplicationActivateAllWindows];
}

- (void) terminateSelectedProcess
{
  [[NSRunningApplication runningApplicationWithProcessIdentifier:11877] terminate];
}


- (NSInteger) processCount
{
  return [usedObjectListModel processInfoCount];
}

@end
