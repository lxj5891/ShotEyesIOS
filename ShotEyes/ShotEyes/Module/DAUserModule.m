//
//  DAUserModule.m
//  ShotEyes
//
//  Created by Antony on 13-12-31.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAUserModule.h"


#define kHTTPHeaderCookieName   @"Set-Cookie"
#define kHTTPHeaderCsrftoken    @"csrftoken"
#define kHTTPHeaderUserID       @"userid"
#define kURLLogin               @"simplelogin?name=%@&pass=%@"
#define kURLYiLogin               @"simplelogin?name=%@&password=%@"
#define kURLLogout              @"simplelogout?token=%@"

@implementation DAUserModule



// 登陆。block回调函数版。
- (void)login:(NSString *)name
           password:(NSString *)password
              code :(NSString *)code
           callback:(void (^)(NSError *error, DAUser *user))callback
{
    NSString *path = [NSString stringWithFormat:kURLYiLogin, name, password];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSDictionary *headers = [operation.response allHeaderFields];
        NSString *cookie = [headers objectForKey:kHTTPHeaderCookieName];
        NSString *csrftoken = [headers objectForKey:kHTTPHeaderCsrftoken];
        NSString *userid = [headers objectForKey:kHTTPHeaderUserID];
        
        // Login信息保存到UserDefautls里
        if (cookie != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:kHTTPCookie];
            //重置cookie
            [[DAAFHttpClient sharedClient] setCookie:cookie];
        }
        if (csrftoken != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:csrftoken forKey:kHTTPCsrfToken];
        }
        if (userid != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:userid forKey:kHTTPUser];
        }
        
        // 调用回调函数
        if (callback) {
            callback(nil, [[DAUser alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if (callback) {
            callback(error, nil);
        }
    }];
}

@end
