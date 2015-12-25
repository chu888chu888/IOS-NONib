//
//  AppRootViewController.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/10/28.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "AppRootViewController.h"
#import "ConversationVC/ConversationViewController.h"
#import "CommonVC/CommonNavigationViewController.h"
#import "FriendListVC/FriendsViewController.h"
#import "GistViewController.h"
@interface AppRootViewController ()

@end

@implementation AppRootViewController

- (void)initChildViewControllers {
    NSMutableArray *childVCArray=[[NSMutableArray alloc] initWithCapacity:5];
    
    ConversationViewController *conversationVC=[[ConversationViewController alloc]init];
    [conversationVC.tabBarItem setTitle:@"消息"];
    [conversationVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_mainframe"]];
    [conversationVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_mainframeHL"]];
    CommonNavigationViewController *convNaVC=[[CommonNavigationViewController alloc]initWithRootViewController:conversationVC];
    [childVCArray addObject:convNaVC];
    
    FriendsViewController *friendVC=[[FriendsViewController alloc]init];
    [friendVC.tabBarItem setTitle:@"通讯录"];
    [friendVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_contacts"]];
    [friendVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]];
    CommonNavigationViewController *friendNaVC=[[CommonNavigationViewController alloc]initWithRootViewController:friendVC];
    [childVCArray addObject:friendNaVC];
    
    /*
    GistViewController *GistVC=[[GistViewController alloc]init];
    [GistVC.tabBarItem setTitle:@"Github"];
    [GistVC.tabBarItem setImage:[UIImage imageNamed:@"tabbar_contacts"]];
    [GistVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]];
    CommonNavigationViewController *GistNaVC=[[CommonNavigationViewController alloc]initWithRootViewController:GistVC];
    [childVCArray addObject:GistNaVC];
    */
    
    GistViewController *gistVC=[[GistViewController alloc]init];
    [gistVC.tabBarItem setTitle:@"Github API"];
    
    FAKFoundationIcons *cogIcon=[FAKFoundationIcons socialGithubIconWithSize:30];
    [cogIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *conImage = [cogIcon imageWithSize:CGSizeMake(30, 30)];
    [gistVC.tabBarItem setImage:conImage];
    [gistVC.tabBarItem setSelectedImage:conImage];
     
    CommonNavigationViewController *gistNaVC=[[CommonNavigationViewController alloc]initWithRootViewController:gistVC];
    [childVCArray addObject:gistNaVC];
    
    
    [self setViewControllers:childVCArray];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundColor:DEFAULT_SEARCHBAR_COLOR];
    [self.tabBar setTintColor:DEFAULT_GREEN_COLOR];
    
    
    [self initChildViewControllers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
