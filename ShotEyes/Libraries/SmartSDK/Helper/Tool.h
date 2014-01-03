//
//  Tool.h
//  DiandianIOS
//
//  Created by Antony on 13-11-26.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject


+ (NSDate *) dateFromISODateString:(NSString *)isodate;
+ (NSString *) stringFromISODateString:(NSString *)isodate;
+ (NSString *) stringFromISODate:(NSDate *)isodate;

+ (NSString *) stringWithPad:(NSString *)str length:(int )length;

// ユーザのファイル保存場所を取得
+ (NSString *) fullPath:(NSString *)fileName;

@end
