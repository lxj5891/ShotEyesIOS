//
//  DAReportCreateViewController.h
//  ShotEyes
//
//  Created by Antony on 13-12-30.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACanvasImageView.h"
#import "Tool.h"
#import "SmartSDK.h"



@interface DAReportCreateViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton           *btnAlbum;
@property (weak, nonatomic) IBOutlet UITextView         *textComment;
@property (weak, nonatomic) IBOutlet DACanvasImageView  *canvasImageView;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;

@end
