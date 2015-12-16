//
//  ConversationViewController.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/10/29.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "ConversationViewController.h"
#import "ConversationCell.h"
#import "FriendSearchViewController.h"
#import "ConversationSearchVC/ConversationSearchViewController.h"
#import "ChatViewController.h"
#import "User.h"
#import "CalendarViewController.h"

@interface ConversationViewController ()<UISearchBarDelegate>
@property(nonatomic,strong) UIBarButtonItem *navRightButton;
@property(nonatomic,strong) UISearchController *searchController;
@property(nonatomic,strong) ConversationSearchViewController *searchVC;
@property(nonatomic,strong) ChatViewController *chatVC;
@end

@implementation ConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册自定义的表格
    [self.tableView registerClass:[ConversationCell class] forCellReuseIdentifier:@"ConversationCell"];
    //初始化视图
    [self initSubViews];
    //获取数据
    _data = [self getTestData];
    
}
/**
 *  初始化子视图
 */
- (void) initSubViews
{
    //导航条标题
    [self.navigationItem setTitle:@"消息"];
    //[self setHidesBottomBarWhenPushed:YES];
    //右边导航条按钮
    _navRightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(navRightButtonDown)];
    [self.navigationItem setRightBarButtonItem:_navRightButton];
    
    //采用FontAwesomeKit做为Icon
    //FAKFontAwesome具体参考http://fontawesome.dashgame.com
    //FAKFoundationIcons参考http://zurb.com/playground/foundation-icon-fonts-3
    //FAKIonIcons参考http://ionicons.com
    //FAKMaterialIcons参考https://google.github.io/material-design-icons/
    //FAKOcticons参考https://octicons.github.com
    //FAKZocial参考http://zocial.smcllns.com
    
    //FAKFontAwesome *cogIcon = [FAKFontAwesome cogIconWithSize:20];
    //FAKFoundationIcons *cogIcon=[FAKFoundationIcons downloadIconWithSize:20];
    //FAKIonIcons *cogIcon=[FAKIonIcons manIconWithSize:30 ];
    //FAKOcticons *cogIcon=[FAKOcticons browserIconWithSize:20];
    FAKMaterialIcons *cogIcon=[FAKMaterialIcons alarmIconWithSize:20];
    [cogIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *leftImage = [cogIcon imageWithSize:CGSizeMake(20, 20)];
    cogIcon.iconFontSize = 15;
    UIImage *leftLandscapeImage = [cogIcon imageWithSize:CGSizeMake(15, 15)];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:leftImage
                       landscapeImagePhone:leftLandscapeImage
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(navLeftButtonDown)];
    
    
    
    
    //设置列表风格样式
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    //设置背景颜色
    [self.tableView.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    
    //搜索条的加入
    _searchVC=[[ConversationSearchViewController alloc] init];
    _searchController=[[UISearchController alloc]initWithSearchResultsController:_searchVC];
    [_searchController setSearchResultsUpdater:_searchVC];
    [_searchController.searchBar setPlaceholder:@"搜索"];
    [_searchController.searchBar setBarTintColor:DEFAULT_SEARCHBAR_COLOR];
    [_searchController.searchBar sizeToFit];
    [_searchController.searchBar setDelegate:self];
    [_searchController.searchBar.layer setBorderWidth:0.5f];
    [_searchController.searchBar.layer setBorderColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0].CGColor];
    [self.tableView setTableHeaderView:_searchController.searchBar];
    
    
}

#pragma mark --生成数据
- (NSMutableArray *) getTestData
{
    NSMutableArray *models = [[NSMutableArray alloc] initWithCapacity:20];
    
    Conversation *item1 = [[Conversation alloc] init];
    item1.from = [NSString stringWithFormat:@"莫小贝"];
    item1.message = @"今天晚上吃什么?";
    item1.avatarURL = [NSURL URLWithString:@"0.jpg"];
    item1.messageCount = 0;
    item1.date = [NSDate date];
    [models addObject:item1];
    
    Conversation *item2 = [[Conversation alloc] init];
    item2.from = [NSString stringWithFormat:@"楚广明"];
    item2.message = @"听说恐怖分子袭击了法国";
    item2.avatarURL = [NSURL URLWithString:@"10.jpeg"];
    item2.messageCount = 0;
    item2.date = [NSDate date];
    [models addObject:item2];
    
    Conversation *item3 = [[Conversation alloc] init];
    item3.from = [NSString stringWithFormat:@"楚多多"];
    item3.message = @"ISIS就是一群禽兽";
    item3.avatarURL = [NSURL URLWithString:@"1.jpg"];
    item3.messageCount = 0;
    item3.date = [NSDate date];
    [models addObject:item3];
    
    Conversation *item4 = [[Conversation alloc] init];
    item4.from = [NSString stringWithFormat:@"张梦瑶"];
    item4.message = @"法国怒了";
    item4.avatarURL = [NSURL URLWithString:@"8.jpg"];
    item4.messageCount = 0;
    item4.date = [NSDate date];
    [models addObject:item4];
    
    return models;
}
#pragma mark --导航点击事件
- (void) navRightButtonDown
{
    
}
- (void) navLeftButtonDown
{
    
    CalendarViewController *calendarVC=[[CalendarViewController alloc] init];
    
    [self setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:calendarVC animated:YES];

}


#pragma mark - UITableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationCell"];
    [cell setConversation:_data[indexPath.row]];
    
    /*
    [cell setTopLineStyle:CellLineStyleNone];
    if (indexPath.row == _data.count - 1) {
        [cell setBottomLineStyle:CellLineStyleFill];
    }
    else {
        [cell setBottomLineStyle:CellLineStyleDefault];
    }
    */
    [cell setTopLineStyle:CellLineStyleNone];
    [cell setBottomLineStyle:CellLineStyleNone];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark --删除事件
- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
#pragma mark --用户选择事件
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_chatVC == nil) {
        _chatVC = [[ChatViewController alloc] init];
    }
    User *user7 = [[User alloc] init];
    user7.username = @"莫小贝";
    user7.userID = @"XB";
    user7.nikename = @"小贝";
    user7.avatarURL = [NSURL URLWithString:@"10.jpeg"];
    _chatVC.user = user7;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:_chatVC animated:YES];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self setHidesBottomBarWhenPushed:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UISearchBarDelegate

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _searchVC.ConversationsArray = self.data;
    [self.tabBarController.tabBar setHidden:YES];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.tabBarController.tabBar setHidden:NO];
}

@end
