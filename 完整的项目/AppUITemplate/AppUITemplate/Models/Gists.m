//
//  Gists.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/17.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "Gists.h"

@implementation Gists
-(void)initialiseWithSafeValues
{
    _url=@"";
    _gistid=@"";
    _forks_url=@"";
    _commits_url=@"";
    _git_pull_url=@"";
    _git_push_url=@"";
    _html_url=@"";
    
    
    _created_at=@"";
    _updated_at=@"";
    _gistdescription=@"";
    _comments_url=@"";
    _truncated=TRUE;
    _ispublic=TRUE;
}
-(id)init
{
    self=[super init];
    if (self) {
        [self initialiseWithSafeValues];
    }
    return self;
}
-(id)initWithArray:(NSArray *)array
{
    self=[super init];
    if(self)
    {
        [self initialiseWithSafeValues];
        _url=[NSString stringWithFormat:@"%@",[array valueForKey:@"url"]];
        _gistid=[NSString stringWithFormat:@"%@",[array valueForKey:@"id"]];
        _created_at=[NSString stringWithFormat:@"%@",[array valueForKey:@"created_at"]];
        _updated_at=[NSString stringWithFormat:@"%@",[array valueForKey:@"updated_at"]];
        _truncated=[array valueForKey:@"truncated"];
        _forks_url=[NSString stringWithFormat:@"%@",[array valueForKey:@"forks_url"]];
        _comments_url=[NSString stringWithFormat:@"%@",[array valueForKey:@"comments_url"]];
        _git_pull_url=[NSString stringWithFormat:@"%@",[array valueForKey:@"git_push_url"]];
        _html_url=[NSString stringWithFormat:@"%@",[array valueForKey:@"html_url"]];
        _gistdescription=[NSString stringWithFormat:@"%@",[array valueForKey:@"description"]];
        _ispublic=[array valueForKey:@"public"];
    }
    return self;
}
#pragma mark -
#pragma mark Dictionary Parsing
-(void)processArray:(NSArray *)array
{
    
}
@end
