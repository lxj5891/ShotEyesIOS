//
//  DAViewController.m
//  ShotEyes
//1123123123
//  Created by Antony on 13-12-27.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAViewController.h"
#import "DAReportCreateViewController.h"
#import "DAReportViewController.h"
#import "SmartSDK.h"

@interface DAViewController ()

@end

@implementation DAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
    DAReportViewController *vc = [[DAReportViewController alloc] initWithNibName:@"DAReportViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:animated];
    [[DAUserModule alloc] login:@"admin" password:@"admin" code:@"" callback:^(NSError *error, DAUser *user) {
        NSLog(@"login success");
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
