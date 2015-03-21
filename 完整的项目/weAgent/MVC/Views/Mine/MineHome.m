//
//  MineHome.m
//  weAgent
//
//  Created by apple on 14/12/5.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "MineHome.h"

@implementation MineHome

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize {
    _listView = [[GlobalUITableView alloc] initWithFrame:CGRectMake(0, 0,[UIView globalWidth],[UIView globalHeight]-93 ) style:UITableViewStyleGrouped];
    [self addSubview:_listView];

    _logoff  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _logoff.frame = CGRectMake(10, 330, [UIView globalWidth] -20, 44);
    [_logoff setTitle:@"退出登录" forState:UIControlStateNormal];
       [_logoff beRed];
    [self.listView addSubview:_logoff];
}



@end
