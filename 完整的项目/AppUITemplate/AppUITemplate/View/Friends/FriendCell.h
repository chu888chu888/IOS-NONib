//
//  FriendCell.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/11/3.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "User.h"
@interface FriendCell : CommonTableViewCell
@property(nonatomic,strong) UIImageView *avatarImageView;
@property(nonatomic,strong) UILabel *usernameLabel;
@property(nonatomic,strong) User *user;
@end
