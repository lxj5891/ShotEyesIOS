//
//  DACanvasImageView.h
//  Report
//
//  Created by 李 林 on 12/05/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DACanvasImageView : UIImageView
{
    CGPoint _touchPoint;
    
    // 画像指定済みフラグ（指定済みの場合は、クリアするときファイルからオリジナル画像を再表示）
    BOOL _isImageSelected;
    
    // 選択情報等、一時保存用
    UIColor  *_penColor;
    NSNumber *_penBold;
}

@property (nonatomic) BOOL isImageSelected;
@property (nonatomic) UIColor *penColor;
@property (nonatomic) NSNumber *penBold;

@end
