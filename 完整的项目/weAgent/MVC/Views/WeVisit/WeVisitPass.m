//
//  WeVisitPass.m
//  weAgent
//
//  Created by 王拓 on 14/12/2.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "WeVisitPass.h"

@implementation WeVisitPass

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
    
    [self addWeVisitListView];
    
}

-(void)addWeVisitListView{
    
    //创建表视图
    float listHeight =[ UIScreen mainScreen ].applicationFrame.size.height-143.0f;
    //设置listView位置及宽高
    _listView = [[GlobalUITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].applicationFrame.size.width, listHeight)];
    
    _listView.rowHeight=100;
    [self addSubview:_listView];
    
}

@end
