//
//  UsedFile.h
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UsedFile : NSObject
{
  @private
    NSString* usedFile;
    NSString* application;
}

@property (copy) NSString *usedFile;
@property (copy) NSString *application;


@end
