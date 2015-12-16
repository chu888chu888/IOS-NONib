//
//  GistDataSource.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/16.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "GistDataSource.h"
#define GistURL @"https://api.github.com/gists/public"
@implementation GistDataSource
+(GistDataSource *)discoverSource
{
    static dispatch_once_t onceToken;
    static GistDataSource *instance=nil;
    dispatch_once(&onceToken,^{
        instance=[[GistDataSource alloc] init];
    });
    return instance;
}
#pragma mark -
#pragma mark Request Methods
-(void)getGistList:(NSString *)UrlParameters completion:(GistDataSourceCompletionBlock)completionBlock
{
    if (completionBlock)
    {
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager GET:GistURL parameters:UrlParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON:%@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error:%@",error);
        }];
    }
}
@end
