//
//  DAReportListViewController.m
//  ShotEyes
//
//  Created by Antony on 13-12-30.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAReportListViewController.h"
#import "DAReportCatalogViewController.h"
#import "DAReportItemListViewController.h"

@interface DAReportListViewController ()
{
    DAReportCatalogViewController       *catalogView;
    DAReportItemListViewController      *itemListView;
}
@end

@implementation DAReportListViewController

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
    catalogView = [[DAReportCatalogViewController alloc] initWithNibName:@"DAReportCatalogViewController" bundle:nil];
    
    itemListView = [[DAReportItemListViewController alloc] initWithNibName:@"DAReportItemListViewController" bundle:nil];
    
    [self addChildViewController:itemListView];
    [self addChildViewController:catalogView];
    itemListView.view.frame = self.viewList.frame;
    catalogView.view.frame = self.viewCatalog.frame;
    [self.view addSubview:catalogView.view];
    [self.view addSubview:itemListView.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
