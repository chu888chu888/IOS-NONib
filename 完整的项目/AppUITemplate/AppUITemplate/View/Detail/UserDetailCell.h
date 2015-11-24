//
//  UserDetailCell.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/11/19.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "User.h"

typedef NS_ENUM(NSInteger, UserDetailCellType) {
    UserDetailCellTypeFriends,
    UserDetailCellTypeMine,
};
@interface UserDetailCell : CommonTableViewCell
@property (nonatomic, assign) UserDetailCellType cellType;
@property (nonatomic, strong) User *user;
@end
