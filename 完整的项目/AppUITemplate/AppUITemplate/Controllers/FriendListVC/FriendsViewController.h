//
//  FriendsViewController.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/11/3.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CommonTableViewController.h"

@interface FriendsViewController : CommonTableViewController
//好友列表数据
@property(nonatomic,strong) NSMutableArray *friendsArray;
//格式化的好友列表数据
@property(nonatomic,strong) NSMutableArray *data;
//拼音首字母列表
@property(nonatomic,strong) NSMutableArray *section;
@end
