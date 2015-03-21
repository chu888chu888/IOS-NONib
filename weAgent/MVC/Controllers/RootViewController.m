//
//  RootViewController.m
//  weChat
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "RootViewController.h"
#import "GlobalNavigationViewController.h"
#import "ViewController.h"
#import "CallRecordViewController.h"
#import "HomeViewController.h"
#import "WeVisitViewController.h"
#import "MineHomeViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController


# pragma mark - 初始化tab视图
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    ViewController *homeVC = [[ViewController alloc] init];
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    GlobalNavigationViewController *homeNVC = [[GlobalNavigationViewController alloc] initWithRootViewController:homeVC];
    homeVC.title = @"首页";
    [homeNVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"lg1f"] withFinishedUnselectedImage:[UIImage imageNamed:@"lg1"]];
    
    CallRecordViewController *callRecordVC = [[CallRecordViewController alloc] init];
    GlobalNavigationViewController *callRecordNVC = [[GlobalNavigationViewController alloc] initWithRootViewController:callRecordVC];
    callRecordVC.title = @"通话记录";
    [callRecordVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"lg2f"] withFinishedUnselectedImage:[UIImage imageNamed:@"lg2"]];
    
    
//    ViewController *weVisitVC = [[ViewController alloc] init];
    WeVisitViewController *weVisitVC = [[WeVisitViewController alloc]init];
    GlobalNavigationViewController *weVisitNVC = [[GlobalNavigationViewController alloc] initWithRootViewController:weVisitVC];
    weVisitVC.title = @"微访谈";
    [weVisitVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"lg3f"] withFinishedUnselectedImage:[UIImage imageNamed:@"lg3"]];
    
    
    MineHomeViewController *mineHomeVC = [[MineHomeViewController alloc] init];
    GlobalNavigationViewController *mineHomeNVC = [[GlobalNavigationViewController alloc] initWithRootViewController:mineHomeVC];
    mineHomeVC.title = @"我的";
    [mineHomeNVC.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"lg4f"] withFinishedUnselectedImage:[UIImage imageNamed:@"lg4"]];
    
    [[UITabBar appearance] setTintColor:[UIColor baseColor]];
    
    NSArray *controllers = [NSArray arrayWithObjects:homeNVC,callRecordNVC,weVisitNVC,mineHomeNVC, nil];
    
    
    [self setViewControllers:controllers];
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
