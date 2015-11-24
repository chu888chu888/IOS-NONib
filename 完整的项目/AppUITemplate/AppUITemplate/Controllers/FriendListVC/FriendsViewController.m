//
//  FriendsViewController.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/11/3.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendCell.h"
#import "DataHelper.h"
#import "TLSetting.h"
#import "UIHelper.h"
#import "FriendSearchViewController.h"
#import "DetailsViewController.h"
@interface FriendsViewController ()<UISearchBarDelegate>
@property(nonatomic,strong) UILabel *footerLabel;
@property(nonatomic,strong) UIBarButtonItem *addFriendButton;
//功能列表
@property (nonatomic, strong) SettingGrounp *functionGroup;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) FriendSearchViewController *searchVC;
@property (nonatomic, strong) DetailsViewController *detailVC;
@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"通讯录"];
    [self setHidesBottomBarWhenPushed:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView registerClass:[FriendCell class] forCellReuseIdentifier:@"FriendCell"];
    
    [self initSubViews];
    [self initTestData];
    
}
- (void) addFriendButtonDown
{

}
#pragma mark --初始化数据
- (void) initSubViews
{
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [self.tableView.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:DEFAULT_NAVBAR_COLOR];
    
    // 添加好友按钮
    _addFriendButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:UIBarButtonItemStylePlain target:self action:@selector(addFriendButtonDown)];
    [self.navigationItem setRightBarButtonItem:_addFriendButton];
    
    // 好友计数
    _footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 49.0f)];
    [_footerLabel setBackgroundColor:[UIColor whiteColor]];
    [_footerLabel setTextColor:[UIColor grayColor]];
    [_footerLabel setTextAlignment:NSTextAlignmentCenter];
    [self.tableView setTableFooterView:_footerLabel];
    
    
    // 搜索
    _searchVC = [[FriendSearchViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_searchVC];
    [_searchController setSearchResultsUpdater: _searchVC];
    [_searchController.searchBar setPlaceholder:@"搜索"];
    [_searchController.searchBar setBarTintColor:DEFAULT_SEARCHBAR_COLOR];
    [_searchController.searchBar sizeToFit];
    [_searchController.searchBar setDelegate:self];
    [_searchController.searchBar.layer setBorderWidth:0.5f];
    [_searchController.searchBar.layer setBorderColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0].CGColor];
    [self.tableView setTableHeaderView:_searchController.searchBar];
}

- (void) initTestData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _friendsArray = [[NSMutableArray alloc] initWithCapacity:3];
        User *user1 = [[User alloc] init];
        user1.username = @"吕轻侯";
        user1.nikename = @"侯哥";
        user1.userID = @"yun";
        user1.avatarURL = [NSURL URLWithString:@"1.jpg"];
        [_friendsArray addObject:user1];
        User *user2 = [[User alloc] init];
        user2.username = @"白展堂";
        user2.userID = @"小白2";
        user2.nikename = @"堂堂";
        user2.avatarURL = [NSURL URLWithString:@"4.jpg"];
        [_friendsArray addObject:user2];
        User *user3 = [[User alloc] init];
        user3.username = @"李秀莲";
        user3.userID = @"xiulian";
        user3.nikename = @"大嘴";
        user3.avatarURL = [NSURL URLWithString:@"8.jpg"];
        [_friendsArray addObject:user3];
        User *user4 = [[User alloc] init];
        user4.username = @"燕小六";
        user4.userID = @"xiao6";
        user4.avatarURL = [NSURL URLWithString:@"11.jpg"];
        [_friendsArray addObject:user4];
        User *user5 = [[User alloc] init];
        user5.username = @"郭芙蓉";
        user5.userID = @"furongMM";
        user5.avatarURL = [NSURL URLWithString:@"12.jpg"];
        [_friendsArray addObject:user5];
        User *user6 = [[User alloc] init];
        user6.username = @"佟湘玉";
        user6.userID = @"yu";
        user6.nikename = @"掌柜嗒";
        user6.avatarURL = [NSURL URLWithString:@"7.jpg"];
        [_friendsArray addObject:user6];
        User *user7 = [[User alloc] init];
        user7.username = @"莫小贝";
        user7.userID = @"XB";
        user7.nikename = @"小贝";
        user7.avatarURL = [NSURL URLWithString:@"10.jpeg"];
        [_friendsArray addObject:user7];
        
        _functionGroup=[UIHelper getFriensListItemsGroup];
        _data = [DataHelper getFriendListDataBy:_friendsArray];
        _section = [DataHelper getFriendListSectionBy:_data];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [_footerLabel setText:[NSString stringWithFormat:@"%lu位联系人", (unsigned long)_friendsArray.count]];
        });
    });
}
#pragma mark -UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return _functionGroup.itemsCount;
    }
    NSArray *array=[_data objectAtIndex:section-1];
    return array.count;
    
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    if (indexPath.section == 0) {
        SettingItem *item = [_functionGroup itemAtIndex:indexPath.row];
        User *user = [[User alloc] init];
        user.username = item.title;
        user.avatarURL = [NSURL URLWithString:item.imageName];
        [cell setUser:user];

    }
    else {
        NSArray *array = [_data objectAtIndex:indexPath.section - 1];
        User *user = [array objectAtIndex:indexPath.row];
        [cell setUser:user];
       
    }
    [cell setTopLineStyle:CellLineStyleNone];
    [cell setBottomLineStyle:CellLineStyleNone];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
    }
    else
    {
        if (_detailVC==nil) {
            _detailVC=[[DetailsViewController alloc] init];
        }
        NSArray *array=[_data objectAtIndex:indexPath.section-1];
        _detailVC.user=[array objectAtIndex:indexPath.row];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:_detailVC animated:YES];
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.5f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 22.0f;
}
//标签
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (label == nil) {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14.5f]];
        [label setTextColor:[UIColor grayColor]];
        [label setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    }
    [label setText:[NSString stringWithFormat:@"  %@", [_section objectAtIndex:section]]];
    return label;
}
//索引
- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _section;
}
- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(index == 0) {
        [self.tableView scrollRectToVisible:_searchController.searchBar.frame animated:NO];
        return -1;
    }
    else {
        return index - 1;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UISearchBarDelegate

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _searchVC.friendsArray = self.friendsArray;
    [self.tabBarController.tabBar setHidden:YES];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.tabBarController.tabBar setHidden:NO];
}

@end
