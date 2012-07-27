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

NSMutableArray* MakeUsedObjectsForProcess(pid_t pid, int maxFileDescriptors)
{
  int fileDescriptorInfoMemorySize = 0;
  int maxfileDescriptorInfoMemorySize = sizeof(struct proc_fdinfo) * maxFileDescriptors;

  // get file descriptors
  struct proc_fdinfo* fileDescriptorInfo = (struct proc_fdinfo*)malloc(maxfileDescriptorInfoMemorySize);
  if ((fileDescriptorInfoMemorySize = proc_pidinfo(pid, PROC_PIDLISTFDS, 0, fileDescriptorInfo, maxfileDescriptorInfoMemorySize)) < 0)
  {
    free(fileDescriptorInfo);
    return 0;
  }
  
  // calculate file descriptor count
  int fileDescriptorInfoCount = fileDescriptorInfoMemorySize / sizeof(struct proc_fdinfo);
  
  // enumerator all file descriptors
  NSMutableArray* objects = [[NSMutableArray alloc] init];
  for (int i = 0; i < fileDescriptorInfoCount; ++i)
  {
    // ignore all not vnode descriptors
    if (fileDescriptorInfo[i].proc_fdtype != PROX_FDTYPE_VNODE)
    {
      continue;
    }

    // get file descriptor path
    struct vnode_fdinfowithpath fileDescriptorInfoWithPath;
    int result = proc_pidfdinfo(pid, fileDescriptorInfo[i].proc_fd, PROC_PIDFDVNODEPATHINFO, &fileDescriptorInfoWithPath, sizeof(struct vnode_fdinfowithpath));
    if (result < sizeof(sizeof(struct vnode_fdinfowithpath)))
    {
      continue;
    }

    // make UsedObject
    UsedObject *object = [[UsedObject alloc] initWithPath: [NSString stringWithCString: fileDescriptorInfoWithPath.pvip.vip_path encoding:NSUTF8StringEncoding]];
    [objects addObject: object];
  }
  
  free(fileDescriptorInfo);
  return objects;
}


//
// MakeProcessWithUsedObjects
//

ProcessWithUsedObjects* MakeProcessWithUsedObjects(pid_t pid)
{
  // get task info (name and max file descriptors count)
  struct proc_taskallinfo taskInfo;
  if (proc_pidinfo(pid, PROC_PIDTASKALLINFO, 0, &taskInfo, sizeof(taskInfo)) < 0)
  {
    return 0;
  }
    
  // get process info (module path)
  struct proc_vnodepathinfo vpi;
  if (proc_pidinfo(pid, PROC_PIDVNODEPATHINFO, 0, &vpi, sizeof(vpi)) < 0)
  {
    return 0;
  }
  
  NSMutableArray* usedObjects = MakeUsedObjectsForProcess(pid, taskInfo.pbsd.pbi_nfiles);
  if (!usedObjects)
  {
    return 0;
  }
  
  return [[ProcessWithUsedObjects alloc]
    initWithName: [NSString stringWithCString:taskInfo.pbsd.pbi_comm encoding:NSUTF8StringEncoding]
    pid: pid
    usedObjects: usedObjects];
}


//
// GetProcessWithUsedObjects
//

NSMutableArray* GetProcessWithUsedObjects()
{
  // get process quantity
  int processQuantity = 0;
  if ((processQuantity = proc_listpids(PROC_ALL_PIDS, 0, NULL, 0)) <= 0)
  {
    return 0;
  }
  
  // get pids for all processes
  pid_t* pids = (int*)malloc(processQuantity * sizeof(pid_t));
  if (proc_listpids(PROC_ALL_PIDS, 0, pids, processQuantity) <= 0)
  {
    free(pids);
    return 0;
  }

  // enumerate all pids
  NSMutableArray* processes = [[NSMutableArray alloc] init];
  for (int i = 0; i < processQuantity; ++i)
  {
    pid_t pid = pids[i];
    if (!pid)
    {
      continue;
    }
      
    // make another object
    [processes addObject: MakeProcessWithUsedObjects(pid)];
  }

  // thats all!
  free(pids);
  return processes;
}
