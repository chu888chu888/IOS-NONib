//
//  CommonViewController.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/10/29.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (void) viewDidLoad
{
    [self.view setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    
    [self setHidesBottomBarWhenPushed:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

@end
