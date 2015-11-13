//
//  ConversationSearchViewController.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/11/13.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "ConversationSearchViewController.h"
#import "FriendCell.h"
#import "ConversationCell.h"
#import "Conversation.h"
@interface ConversationSearchViewController ()
@property(nonatomic,copy) NSMutableArray *data;
@end

@implementation ConversationSearchViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[ConversationCell class] forCellReuseIdentifier:@"ConversationCell"];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    _data = [[NSMutableArray alloc] init];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.originY = HEIGHT_NAVBAR + HEIGHT_STATUSBAR;
    self.tableView.frameHeight = HEIGHT_SCREEN - self.tableView.originY;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
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

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"联系人";
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConversationCell"];
    
    Conversation *conversationMsg = [_data objectAtIndex:indexPath.row];
    [cell setConversation:conversationMsg];
    indexPath.row == 0 ? [cell setTopLineStyle:CellLineStyleFill] : [cell setTopLineStyle:CellLineStyleNone];
    indexPath.row == _data.count - 1 ? [cell setBottomLineStyle:CellLineStyleFill] : [cell setBottomLineStyle:CellLineStyleDefault];
    
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.5f;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    [_data removeAllObjects];
    for (Conversation *user in _ConversationsArray) {
        if ([user.message containsString:searchText] || [user.from containsString:searchText] || [user.from containsString:searchText]) {
            [_data addObject:user];
        }
    }
    [self.tableView reloadData];
}


@end
