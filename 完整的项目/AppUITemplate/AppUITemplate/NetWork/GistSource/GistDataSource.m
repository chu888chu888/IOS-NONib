//
//  GistDataSource.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/16.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "GistDataSource.h"
#import "Gists.h"
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
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                completionBlock([self processResponseObject:responseObject], nil);
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [UIView addMJNotifierWithText:@"网络故障请重试" dismissAutomatically:YES];
        }];
    }
}
#pragma mark -
#pragma mark Data Parsing

- (NSMutableArray*)processResponseObject:(NSDictionary*)data
{
    if (data == nil)
    {
        return nil;
    }
    NSMutableArray* sortedArray = [[NSMutableArray alloc] init];
    for (NSArray* item in data)
    {
        
        Gists *gist=[[Gists alloc] initWithArray:item];
        [sortedArray addObject:gist];
        
        /*
        Gists *gist=[[Gists alloc]init];
        [sortedArray addObject:gist];
         */
    }

    return sortedArray;
}

@end
