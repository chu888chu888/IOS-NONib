//
//  RadarSet.m
//  weAgent
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "RadarSet.h"

@implementation RadarSet

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void)initialize{
    //调用方法添加页面元素
    [self addTableView];
    [self addPickerView];
    [self initValueLable];
}

-(void)addTableView{
    _tableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor baseBackgroundColor];
    [self addSubview:_tableView];
}

-(void)addPickerView{
    UIView *beSureView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIView globalWidth], 44)];
    beSureView.backgroundColor = [UIColor goodDarkColor];
    
    _sureButton= [[UIButton alloc] initWithFrame:CGRectMake([UIView globalWidth]-60, 0.0, 60, 44)];
    [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [beSureView addSubview:_sureButton];
    _pickView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIView globalHeight], [UIView globalWidth], 204)];
    _pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, [UIView globalWidth], 160)];
    [_pickView addSubview:beSureView];
    [_pickView addSubview:_pickerview];
    [self addSubview:_pickView];
    // Do any additional setup after loading the view.
}

-(void)initValueLable{
    _beforeValueLable = [[UILabel alloc] initWithFrame:CGRectMake([UIView globalWidth] - 140, 0, 100, 44)];
    _beforeValueLable.font =[UIFont baseWithSize:12];
    _beforeValueLable.textColor =[UIColor grayColor];
    _beforeValueLable.textAlignment = NSTextAlignmentRight;
    _beforeValueLable.text=@"∞天";
    
    _distanceValueLable = [[UILabel alloc] initWithFrame:CGRectMake([UIView globalWidth] - 140, 0, 100, 44)];
    _distanceValueLable.font =[UIFont baseWithSize:12];
    _distanceValueLable.textColor =[UIColor grayColor];
    _distanceValueLable.textAlignment = NSTextAlignmentRight;
    _distanceValueLable.text=@"∞米";
    
    _ifUseSettedHomeSwitch = [[ UISwitch alloc]initWithFrame:CGRectMake([UIView globalWidth] -90 ,6.0,0.0,0.0)];
}
@end
