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
            NSLog(@"Error:%@",error);
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
    for (NSDictionary* item in data)
    {
        Gists* gist = [[Gists alloc] init];
        
        gist.url=[item valueForKey:@"url"];
        gist.gistid=[item valueForKey:@"id"];
        gist.created_at=[item valueForKey:@"created_at"];
        gist.updated_at=[item valueForKey:@"updated_at"];
        gist.truncated=[item valueForKey:@"truncated"];
        gist.forks_url=[item valueForKey:@"forks_url"];
        gist.comments_url=[item valueForKey:@"commits_url"];
        gist.git_pull_url=[item valueForKey:@"git_pull_url"];
        gist.html_url=[item valueForKey:@"html_url"];
        gist.gistdescription=[item valueForKey:@"description"];
        gist.comments_url=[item valueForKey:@"comments_url"];
        gist.ispublic=[item valueForKey:@"public"];
        
        [sortedArray addObject:gist];
    }

    return sortedArray;
}

@end
