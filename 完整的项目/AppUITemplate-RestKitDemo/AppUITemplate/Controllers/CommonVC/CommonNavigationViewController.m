//
//  CommonNavigationViewController.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/10/29.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CommonNavigationViewController.h"

@interface CommonNavigationViewController ()

@end

@implementation CommonNavigationViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:DEFAULT_NAVBAR_COLOR];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.view setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
