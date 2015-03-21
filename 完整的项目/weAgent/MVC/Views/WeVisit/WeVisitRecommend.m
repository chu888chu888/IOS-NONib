//
//  WeVisitRecommend.m
//  weAgent
//
//  Created by 王拓 on 14/11/30.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "WeVisitRecommend.h"

@implementation WeVisitRecommend

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

/**
 *  初始化页面
 */
-(void)initialize{
    [self addListView];
}


/**
 *  添加表视图
 */
-(void) addListView{
    
    float listHeight =[ UIScreen mainScreen ].applicationFrame.size.height-143.0f;
    _listView = [[GlobalUITableView alloc] initWithFrame:CGRectMake(0, 0,[ UIScreen mainScreen ].applicationFrame.size.width, listHeight)];
    //定义单元格高度
    _listView.rowHeight=280;
    
    [self addSubview:_listView];
}
@end
