//
//  DAFileModule.m
//  ShotEyes
//
//  Created by Antony on 13-12-31.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAFileModule.h"

@implementation DAFileModule

- (NSString *)appendCsrf:(NSString *)path
{
    NSString *csrftoken = [[NSUserDefaults standardUserDefaults] objectForKey:kHTTPCsrfToken];
    NSString *spliter = [path rangeOfString:@"?"].location == NSNotFound ? @"?" : @"&";
    
    return [NSString stringWithFormat:@"%@%@_csrf=%@", path, spliter, [DARequestHelper uriEncodeForString:csrftoken]];
}

- (void)uploadPicture:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType callback:(void (^)(NSError *error, NSString *files))callback progress:(void (^)(CGFloat percent))progress
{
    DAAFHttpClient *httpClient = [DAAFHttpClient sharedClient];
    
    // 添加formData到Request
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST"
                                                                         path:API_FILE_UPLOAD
                                                                   parameters:nil
                                                    constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
                                                        
                                                        [formData appendPartWithFileData:data name:@"Filedata" fileName:fileName mimeType:mimeType];
                                                    }];
    
    // 设定上传进度block
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if (progress) {
            progress((CGFloat)totalBytesWritten / (CGFloat)totalBytesExpectedToWrite);
        }
    }];
    
    // 设定上传结束block
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if (callback) {
            NSError *jsonError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&jsonError];
            
            NSString *files =  [result objectForKey:@"data"];
            
            callback(jsonError, files);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
    
    [httpClient enqueueHTTPRequestOperation:operation];
}

@end
