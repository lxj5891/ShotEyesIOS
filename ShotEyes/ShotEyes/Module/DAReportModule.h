//
//  DAReportModule.h
//  ShotEyes
//
//  Created by Antony on 13-12-31.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

//{ id: '',
//version: '',
//attachment: '52c2849d7f9f0ad717000006',
//comment: '123213',
//    tags: '23' }

#import <Foundation/Foundation.h>
#import "SmartSDK.h"

@interface DAReportModule : NSObject

-(void) addReport:(NSString *)comment attachment:(NSString *)attachment tags:(NSString *)tags callback:(void (^)(NSError *err, DAReport *report))callback;

@end
