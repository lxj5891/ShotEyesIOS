//
//  DAFileModule.h
//  ShotEyes
//
//  Created by Antony on 13-12-31.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAAFHttpClient.h"
#import "DAAFHttpOperation.h"
#import "SmartSDK.h"


@interface DAFileModule : NSObject

- (void)uploadPicture:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType callback:(void (^)(NSError *error, NSString *files))callback progress:(void (^)(CGFloat percent))progress;

@end
