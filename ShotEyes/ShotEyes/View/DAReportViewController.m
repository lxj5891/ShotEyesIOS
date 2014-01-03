//
//  DAReportViewController.m
//  ShotEyes
//
//  Created by Antony on 13-12-30.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAReportViewController.h"
#import "DAReportCreateViewController.h"
#import "DAReportListViewController.h"

@interface DAReportViewController ()
{
    DAReportListViewController          *listViewVC;
    DAReportCreateViewController        *createViewVC;
}
@end

@implementation DAReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    createViewVC = [[DAReportCreateViewController alloc] initWithNibName:@"DAReportCreateViewController" bundle:nil];
    listViewVC = [[DAReportListViewController alloc] initWithNibName:@"DAReportListViewController" bundle:nil];
    
    [self addChildViewController:createViewVC];
    [self addChildViewController:listViewVC];
    
    createViewVC.view.frame = self.viewBlock.frame ;
    [self.view addSubview:createViewVC.view];
    self.tabBar.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self changeView:item.tag];
}

- (void) changeView :(int )tag
{
    if (tag == 1) {
        
        [listViewVC removeFromParentViewController];
        createViewVC.view.frame = self.viewBlock.frame ;
        [self.view addSubview:createViewVC.view];
        self.tabBar.delegate = self;
        
    } else if (tag == 2) {
        
        [createViewVC removeFromParentViewController];
        listViewVC.view.frame = self.viewBlock.frame ;
        [self.view addSubview:listViewVC.view];
        self.tabBar.delegate = self;
        
    }
}
@end
