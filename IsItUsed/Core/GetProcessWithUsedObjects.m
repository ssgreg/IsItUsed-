//
//  GetProcessWithUsedObjects.m
//  IsItUsed
//
//  Created by Grigory Zubankov on 7/27/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// IsItUsed
#import "UsedObject.h"
#import "ProcessWithUsedObjects.h"
#import "GetProcessWithUsedObjects.h"
// Foundation
#import <Foundation/Foundation.h>
//
#include <libproc.h>


//
// MakeUsedObjectsForProcess
//

NSMutableArray* MakeUsedObjectsForProcess(pid_t pid, int fdiMaxCount)
{
  int fdiSize = 0;
  int fdiMaxSize = sizeof(struct proc_fdinfo) * fdiMaxCount;

  // get file descriptors
  struct proc_fdinfo* fdis = (struct proc_fdinfo*)malloc(fdiMaxSize);
  if ((fdiSize = proc_pidinfo(pid, PROC_PIDLISTFDS, 0, fdis, fdiMaxSize)) <= 0)
  {
    free(fdis);
    return 0;
  }
  
  // calculate file descriptor count
  int fdiCount = fdiSize / sizeof(struct proc_fdinfo);
  
  // enumerator all file descriptors
  NSMutableArray* objects = [[NSMutableArray alloc] init];
  for (int i = 0; i < fdiCount; ++i)
  {
    // ignore all not vnode descriptors
    if (fdis[i].proc_fdtype != PROX_FDTYPE_VNODE)
    {
      continue;
    }

    // get file descriptor path
    struct vnode_fdinfowithpath fdiwp;
    int result = proc_pidfdinfo(pid, fdis[i].proc_fd, PROC_PIDFDVNODEPATHINFO, &fdiwp, sizeof(struct vnode_fdinfowithpath));
    if (result < sizeof(sizeof(struct vnode_fdinfowithpath)))
    {
      continue;
    }

    // make and push UsedObject
    UsedObject *object = [[UsedObject alloc]
      initWithPath: [NSString stringWithCString: fdiwp.pvip.vip_path encoding:NSUTF8StringEncoding]];
    [objects addObject: object];
  }
  
  free(fdis);
  return objects;
}


//
// MakeProcessWithUsedObjects
//

ProcessWithUsedObjects* MakeProcessWithUsedObjects(pid_t pid)
{
  // get task info (name and max file descriptors count)
  struct proc_taskallinfo tai;
  if (proc_pidinfo(pid, PROC_PIDTASKALLINFO, 0, &tai, sizeof(tai)) < sizeof(tai))
  {
    return 0;
  }
    
  // get process info (module path)
  struct proc_vnodepathinfo vpi;
  if (proc_pidinfo(pid, PROC_PIDVNODEPATHINFO, 0, &vpi, sizeof(vpi)) < sizeof(vpi))
  {
    return 0;
  }
  
  NSMutableArray* usedObjects = MakeUsedObjectsForProcess(pid, tai.pbsd.pbi_nfiles);
  if (!usedObjects)
  {
    return 0;
  }
  
  return [[ProcessWithUsedObjects alloc]
    initWithName: [NSString stringWithCString: tai.pbsd.pbi_comm encoding: NSUTF8StringEncoding]
    pid: pid
    usedObjects: usedObjects];
}


//
// GetProcessWithUsedObjects
//

NSMutableArray* GetProcessWithUsedObjects()
{
  int const sizeStepIncrement = sizeof(pid_t) * 32;
  
  // determine how many bytes are needed to contain pid list
  int requiredSize = 0;
  if ((requiredSize = proc_listpids(PROC_ALL_PIDS, 0, nil, 0)) <= 0)
  {
    return 0;
  }
 
  // fix memory size (multiple of sizeIncrement)
  int pidListSize = (requiredSize + sizeStepIncrement - 1) / sizeStepIncrement * sizeStepIncrement;

  // allocate memory for all pids in the list
  pid_t* pids = (int*)malloc(pidListSize);

  // number of pids
  int pidCount = 0;
  
  // try to get all pids at _once_
  for (;;)
  {
    if ((requiredSize = proc_listpids(PROC_ALL_PIDS, 0, pids, pidListSize)) <= 0)
    {
      free(pids);
      return 0;
    }
    
    if (requiredSize + sizeof(pid_t) < pidListSize)
    {
      // buffer should be bigger at least by one pid
      pidCount = requiredSize / sizeof(pid_t);
      break;
    }
    else
    {
      // reallocate bigger buffer
      pidListSize += sizeStepIncrement;
      pids = (int*)realloc(pids, pidListSize);
    }
  }

  // enumerate all pids
  NSMutableArray* processes = [[NSMutableArray alloc] init];
  for (int i = 0; i < pidCount; ++i)
  {
    ProcessWithUsedObjects* object = MakeProcessWithUsedObjects(pids[i]);
    if (object)
    {
      // make another object
      [processes addObject: object];
    }
  }

  // thats all!
  free(pids);
  return processes;
}
