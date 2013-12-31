//
//  DAAppDelegate.h
//  ShotEyesPhone
//
//  Created by Antony on 13-12-30.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSDynamicsDrawerViewController.h"
@class MSDynamicsDrawerViewController;

@interface DAAppDelegate : UIResponder <UIApplicationDelegate>


@property (nonatomic, strong) UIImageView *windowBackground;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

@end
