//
//  DACanvasImageView.m
//  Report
//
//  Created by 李 林 on 12/05/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DACanvasImageView.h"

@implementation DACanvasImageView
@synthesize penColor = _penColor;
@synthesize penBold = _penBold;
@synthesize isImageSelected = _isImageSelected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isImageSelected) {
        return;
    }
    
    // タッチ開始座標をインスタンス変数touchPointに保持
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isImageSelected) {
        return;
    }
    
    // 現在のタッチ座標をローカル変数currentPointに保持
    UITouch *touch = [touches anyObject]; 
    CGPoint currentPoint = [touch locationInView:self];
    
    // 描画領域をcanvasの大きさで生成
    UIGraphicsBeginImageContext(self.frame.size);
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    // 線の角を丸くする
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    // 線の太さを指定
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _penBold.floatValue);
    
    // 線の色を指定（RGB）
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    [_penColor getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, alpha);
    
    // 線の描画座標をセット
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _touchPoint.x, _touchPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    // 描画の開始～終了座標まで線を引く
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    // 描画領域を画像（UIImage）としてcanvasにセット
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _touchPoint = currentPoint;
}

@end
