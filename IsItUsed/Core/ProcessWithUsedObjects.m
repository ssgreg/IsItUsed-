//
//  ProcessWithUsedObjects.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/27/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "ProcessWithUsedObjects.h"


//
// ProcessWithUsedObjects
//

@implementation ProcessWithUsedObjects

// interface

- (id) initWithName: (NSString*) newName pid: (pid_t) newPid usedObjects: (NSMutableArray*) newUsedObjects
{
  self = [super init];
  if (self)
  {
    name = newName;
    pid = newPid;
    usedObjects = newUsedObjects;
    appName = [[self runningApplication] localizedName];
    appIcon = [[self runningApplication] icon];
  }
  return self;
}

- (void) activate;
{
  [[self runningApplication] activateWithOptions: NSApplicationActivationPolicyRegular];
}

- (void) terminate
{
  [[self runningApplication] terminate];
}

// private methods

- (NSRunningApplication*) runningApplication
{
  return [NSRunningApplication runningApplicationWithProcessIdentifier:pid];
}

// properties

@synthesize name;
@synthesize pid;
@synthesize appName;

@end
