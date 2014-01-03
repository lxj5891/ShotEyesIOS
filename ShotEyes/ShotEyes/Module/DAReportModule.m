//
//  DAReportModule.m
//  ShotEyes
//
//  Created by Antony on 13-12-31.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAReportModule.h"

@implementation DAReportModule

-(void) addReport:(NSString *)comment attachment:(NSString *)attachment tags:(NSString *)tags callback:(void (^)(NSError *err, DAReport *report))callback
{
    NSString *path = [NSString stringWithFormat:API_REPORT_SAVE];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:attachment forKey:@"attachment"];
    [dic setObject:tags forKey:@"tags"];
    [dic setObject:comment forKey:@"comment"];
    
    
    [[DAAFHttpClient sharedClient] postPath:path parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAReport *data = [[DAReport alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

@end
