//
//  DAUserModule.h
//  ShotEyes
//
//  Created by Antony on 13-12-31.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DAUser.h"
#import "SmartSDK.h"

@interface DAUserModule : NSObject


- (void)login:(NSString *)name
           password:(NSString *)password
              code :(NSString *)code
     callback:(void (^)(NSError *error, DAUser *user))callback;


@end
