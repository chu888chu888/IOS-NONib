//
//  WeVisitDetail.m
//  weAgent
//
//  Created by 王拓 on 14/12/3.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "WeVisitDetail.h"

@implementation WeVisitDetail

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];//先调用父类的initWithframe方法
    if (self) {
        //定义自己的初始化操作
        [self initialize];
    }
    return self;
}

- (void)initialize{
    
    [self addTitle];
    [self addInfo];
    
}


/**
 *  添加标题
 */
-(void)addTitle{
    
    _title=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth]-40, 30)];
    [_title setNumberOfLines:0];
    
    _title.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:18];
    _title.text=@"杨传伟：换个方式做销售";
    
    CSLinearLayoutItem *item=[CSLinearLayoutItem layoutItemForView:_title];
    item.padding=CSLinearLayoutMakePadding(30.0, 20.0, 0.0, 10.0);
    [self.linearLayoutView addItem:item];
}

/**
 *  添加文章信息
 */
-(void)addInfo{
    _info=[[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth]-40, 20)];
    _info.font=[UIFont fontWithName:@"Helvetica" size:10];
    _info.textColor=[UIColor grayColor];
    _info.text=@"发表于 2014年11月15日 浏览次数 7691";
    CSLinearLayoutItem *subInfo=[CSLinearLayoutItem layoutItemForView:_info];
    subInfo.padding=CSLinearLayoutMakePadding(1, 20, 0.0, 10);
    [self.linearLayoutView addItem:subInfo];
}

@end
