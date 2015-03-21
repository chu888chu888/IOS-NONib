//
//  RadarSet.h
//  weAgent
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalUIView.h"


@interface RadarSet : GlobalUIView


@property (nonatomic) UIView *pickView;
@property (nonatomic) UIPickerView *pickerview;
@property (nonatomic) UILabel *beforeValueLable;
@property (nonatomic) UILabel *distanceValueLable;
@property (nonatomic) UISwitch* ifUseSettedHomeSwitch;
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIButton *sureButton;
@end
