//
//  DAMenusViewController.h
//  ShotEyesPhone
//
//  Created by Antony on 13-12-30.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSDynamicsDrawerViewController.h"

typedef NS_ENUM(NSUInteger, MSPaneViewControllerType) {
    DAReportCreateViewControllerType,
    DAReportListViewControllerType,
    
};

@interface DAMenusViewController : UIViewController

@property (nonatomic, assign) MSPaneViewControllerType paneViewControllerType;
@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;
- (void)transitionToViewController:(MSPaneViewControllerType)paneViewControllerType;

@end
