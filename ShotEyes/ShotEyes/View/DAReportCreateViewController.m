//
//  DAReportCreateViewController.m
//  ShotEyes
//
//  Created by Antony on 13-12-30.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAReportCreateViewController.h"
#import "ProgressHUD.h"

@interface DAReportCreateViewController ()
{
    UIPopoverController *_popover;
    NSString *tags;
    NSString *fileId;
    UIProgressView *progbar;
}

@end

@implementation DAReportCreateViewController

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
    progbar = (UIProgressView *)[self.view viewWithTag:900];
    [progbar setHidden:YES];
    self.textComment.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAlbumsClicked:(id)sender
{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    
    // UIPopoverControllerを表示する
    CGRect popoverPos = CGRectMake(_btnAlbum.frame.origin.x, _btnAlbum.frame.origin.y , _btnAlbum.frame.size.width, _btnAlbum.frame.size.height);
    _popover = [[UIPopoverController alloc] initWithContentViewController:imgPicker];
    [_popover presentPopoverFromRect:popoverPos
                              inView:self.view
            permittedArrowDirections:UIPopoverArrowDirectionAny
                            animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (_popover.popoverVisible) {
        [_popover dismissPopoverAnimated:YES];
    }
    NSLog(@"info %@" ,info);
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(originalImage, 1);
    [data writeToFile:[Tool fullPath:kOriginalImage] atomically:YES];
    
    _canvasImageView.isImageSelected = YES;
    _canvasImageView.image = originalImage;

}


- (IBAction)onCreateReportTouched:(id)sender {

    
    NSData *jpegData = [self optimizeImage:[Tool fullPath:kOriginalImage]];
    NSString *comment = self.textComment.text;
    
    if (jpegData.length == 0 ) {
        [ProgressHUD showError:@"请选择图片！！！"];
        return;
    }

    if (comment.length == 0) {
        [ProgressHUD showError:@"请输入图片的描述信息!!!"];
        return;
    }
    
    [progbar setHidden:NO];
    [[DAFileModule alloc] uploadPicture:jpegData fileName:@"phone.png" mimeType:@"image/png" callback:^(NSError *error, NSString *files) {

        [[DAReportModule alloc] addReport:self.textComment.text attachment:files tags:@"123123" callback:^(NSError *err, DAReport *report) {
            [progbar setHidden:YES];
            [ProgressHUD showSuccess:@"报告提交成功！！！"];
        }];
        
    } progress:^(CGFloat percent) {
        NSLog(@"percent  %f" ,percent);
        
        [progbar setProgress:percent];
    }];
    
}

// 优化图片数据的大小
-(NSData *)optimizeImage:(NSString *)file
{
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:file];
    CGFloat compressionQuality = 1;
    NSData *jpegData = [[NSData alloc] initWithData: UIImageJPEGRepresentation( image, compressionQuality )];
    NSLog(@"Image width: %f, height: %f, scale:%f", image.size.height, image.size.width,image.scale);
    
    // 这个块里的代码留着以后参照
    {
        //NSError *attributesError = nil;
        //NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:file error:&attributesError];
        //int fileSize = [fileAttributes fileSize];
        
        ////NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
        ////long long fileSize2 = [fileSizeNumber longLongValue];
        
        //CGFloat oldCompression = 1;
        //if(jpegData.length > 0)
        //    oldCompression = fileSize / jpegData.length;
    }
    
    NSUInteger limitLength = 300 * 1024;    // 限定图片尺寸300K
    NSUInteger minChangeLength = 10 * 1024; // 最小减少的尺寸10K
    
    // 压缩图片
    NSUInteger lastLength;
    while (jpegData.length > limitLength) {
        if (jpegData.length > limitLength * 3)     // 大于限定大小3倍时
            compressionQuality *= 0.5f; // 50%
        else if(jpegData.length > limitLength * 2) // 大于限定大小2倍时
            compressionQuality *= 0.6f; // 60%
        else
            compressionQuality *= 0.8f; // 80%
        
        lastLength = jpegData.length;
        jpegData = [[NSData alloc] initWithData: UIImageJPEGRepresentation( image, compressionQuality )];
        NSLog(@"compressionQuality=%f; jpegData.length=%d" ,compressionQuality, jpegData.length);
        
        // 压缩后减少的尺寸太少时，不用再压缩
        if((lastLength - jpegData.length) < minChangeLength)
            break;
    }
    
    // 尺寸还大时，进行缩放，这里的算法以后在可优化
    if (jpegData.length > limitLength + minChangeLength) {
        UIImage *newImage = image;
        NSArray *scaleArray = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.85]//
                               ,[NSNumber numberWithFloat:0.5]//
                               ,[NSNumber numberWithFloat:0.25]//
                               ,[NSNumber numberWithFloat:0.20]//
                               ,[NSNumber numberWithFloat:0.15]//
                               ,[NSNumber numberWithFloat:0.10]//
                               ,[NSNumber numberWithFloat:0.05]//
                               ,nil];
        
        CGSize newSize = CGSizeMake(newImage.size.width, newImage.size.height);
        for (NSNumber *scale in scaleArray) {
            // 缩放图片
            newSize = CGSizeMake(newSize.width * scale.floatValue, newSize.height * scale.floatValue);
            UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
            [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            NSLog(@"After scale, image size: %fx%f" ,newImage.size.width, newImage.size.height);
            
            // 按最后一次的压缩率重新生成缩放后的图片数据
            jpegData = [[NSData alloc] initWithData: UIImageJPEGRepresentation( newImage, compressionQuality )];
            NSLog(@"After scale, image data length: %d" ,jpegData.length);
            
            // 缩放后减少的尺寸太少时，不用再缩放
            if(jpegData.length <= limitLength + minChangeLength)
                break;
        }
    }
    
    return jpegData;
}

@end
