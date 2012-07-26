//
//  UsedFileFilter.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/26/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// UsedFileFilter
//
@interface UsedFileFilter : NSObject
{
  @private
    NSString* filter;
    NSMutableArray* allFiles;
    NSMutableArray* filteredFiles;
}

@property (readonly) NSMutableArray* filteredFiles;

- (id)init:(NSMutableArray*) usedFiles;
- (void)setFilter:(NSString*) filter;

@end
