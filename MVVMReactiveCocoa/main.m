//
//  main.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/13.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRCAppDelegate.h"
#import <FBAllocationTracker/FBAllocationTrackerManager.h>

int main(int argc, char * argv[]) {
    [[FBAllocationTrackerManager sharedManager] startTrackingAllocations];
    [[FBAllocationTrackerManager sharedManager] enableGenerations];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([MRCAppDelegate class]));
    }
}
