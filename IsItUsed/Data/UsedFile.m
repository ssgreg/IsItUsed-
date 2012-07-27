//
//  UsedFile.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/25/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

#import "UsedFile.h"


@implementation UsedFile

@synthesize usedFile;
@synthesize application;

- (id)init
{
  self = [super init];
  if (self)
  {
    usedFile = @"File";
    application = @"Application";
  }
  return self;
}

@end
