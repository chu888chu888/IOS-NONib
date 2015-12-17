//
//  Gists.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/17.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gists : NSObject
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *forks_url;
@property (nonatomic, strong) NSString *commits_url;
@property (nonatomic, strong) NSString *git_pull_url;
@property (nonatomic, strong) NSString *git_push_url;
@property (nonatomic, strong) NSString *html_url;
@end
