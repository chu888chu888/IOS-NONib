//
//  RadarList.m
//  weAgent
//
//  Created by apple on 14/12/1.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "RadarList.h"

@implementation RadarList

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
    [self addSortView];
    [self addListView];
   
}

- (void) addSortView
{
    //加底线
    UIView *sortView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIView globalWidth], 44)];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIView globalWidth], 44)];
    [bgView setImage:[UIImage imageNamed:@"bg_deal_buyAction"]];
    [sortView addSubview:bgView];
    
    //加竖线
    UIImageView *lineItemOneView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIView globalWidth]-70)/2, 10.0, 1,24)];
    [lineItemOneView setImage:[UIImage imageNamed:@"icon_deal_verticalline"]];
    [sortView addSubview:lineItemOneView];
    
    UIImageView *lineItemTwoView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIView globalWidth]-70), 0.0, 1,42)];
    [lineItemTwoView setImage:[UIImage imageNamed:@"icon_deal_verticalline"]];
    [sortView addSubview:lineItemTwoView];

    //加字
    _timeSortBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ([UIView globalWidth]-70)/2, 42)];
    [_timeSortBtn setTitle:@"时间排序" forState:UIControlStateNormal];
    [_timeSortBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _timeSortBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [sortView addSubview:_timeSortBtn];
    
    _trustSortBtn = [[UIButton alloc] initWithFrame:CGRectMake(([UIView globalWidth]-70)/2, 0, ([UIView globalWidth]-70)/2-1, 42)];
    [_trustSortBtn setTitle:@"可用度排序" forState:UIControlStateNormal];
    [_trustSortBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _trustSortBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [sortView addSubview:_trustSortBtn];
    
    _pickBtn = [[UIButton alloc] initWithFrame:CGRectMake(([UIView globalWidth]-70), 0, 69, 42)];
    [_pickBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [_pickBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _pickBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [sortView addSubview:_pickBtn];

    [self addSubview:sortView];
}

-(void) addListView{
    float listHeight =[ UIScreen mainScreen ].applicationFrame.size.height-88.0f;
    _listView = [[GlobalUITableView alloc] initWithFrame:CGRectMake(0, 44,[ UIScreen mainScreen ].applicationFrame.size.width, listHeight)];
    
    _listView.rowHeight=66;
    
    [self addSubview:_listView];
}



@end
