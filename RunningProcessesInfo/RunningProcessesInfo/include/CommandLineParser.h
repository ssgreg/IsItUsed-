//
//  CommandLineParser.h
//  RunningProcessInfo
//
//  Created by Grigory Zubankov on 9/4/12.
//  Copyright (c) 2012 Grigory Zubankov. All rights reserved.
//

// Foundation
#import <Foundation/Foundation.h>


//
// JetGetProcessArguments
//

NSArray* JetGetProcessArguments(pid_t pid);


//
// ParseProcessArguments
//

NSArray* JetParseProcessArguments(char const* buffer, size_t bufSize);
