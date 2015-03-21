//
//  AccountInfo.m
//  weAgent
//
//  Created by 王拓 on 14/12/17.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "AccountInfo.h"

@implementation AccountInfo

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize {

    _listView = [[GlobalUITableView alloc] initWithFrame:CGRectMake(0, 0,[UIView globalWidth],[UIView globalHeight] ) style:UITableViewStyleGrouped];
    [self addSubview:_listView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
