//
//  RadarList.h
//  weAgent
//
//  Created by apple on 14/12/1.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalUIView.h"
#import "GlobalUITableView.h"
@interface RadarList : GlobalUIView
@property (nonatomic) GlobalUITableView *listView;
@property (nonatomic) UIButton *timeSortBtn;
@property (nonatomic) UIButton *trustSortBtn;
@property (nonatomic) UIButton *pickBtn;
@end
