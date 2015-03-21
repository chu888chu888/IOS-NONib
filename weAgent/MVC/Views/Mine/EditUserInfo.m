//
//  EditUserInfo.m
//  weAgent
//
//  Created by 王拓 on 14/12/17.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "EditUserInfo.h"

@implementation EditUserInfo


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize
{

    [self addInput];
    
}

-(void) addInput{
    
    _nameText = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth]-20, 44)];
    _nameText.borderStyle = UITextBorderStyleNone;
    [_nameText beGreen];
    CSLinearLayoutItem *nameTextitem = [CSLinearLayoutItem layoutItemForView:_nameText];
    nameTextitem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    nameTextitem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:nameTextitem];
    
    _commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth]-20, 44)];
    [_commitBtn beOrange];
    [_commitBtn setTitle:@"确认更改" forState:UIControlStateNormal];
    CSLinearLayoutItem *commitBtnItem = [CSLinearLayoutItem layoutItemForView:_commitBtn];
    commitBtnItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    commitBtnItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:commitBtnItem];

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
