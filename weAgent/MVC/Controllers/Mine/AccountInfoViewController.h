//
//  AccountInfoViewController.h
//  weAgent
//
//  Created by 王拓 on 14/12/17.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalViewController.h"
#import "AccountInfo.h"
@class CSLinearLayoutView;
@interface AccountInfoViewController : GlobalViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) AccountInfo *view;
@property (nonatomic) UIImageView *portraitImageView;
@property (nonatomic, strong) CSLinearLayoutView *linearLayoutView;

@property (nonatomic) UILabel *nameLab;
@property (nonatomic) UILabel *accountLab;
@end
