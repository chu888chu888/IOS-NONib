//
//  SetRadarViewController.m
//  weAgent
//
//  Created by apple on 14-10-23.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "RadarSetViewController.h"
#import "LocationSetViewController.h"

NSString *const BEFORE_DAY_PICK = @"before";
NSString *const DISTANCE_PICK = @"distance";

@interface RadarSetViewController (){
    NSArray *beforeAry;
    NSArray *distanceAry;
    NSArray *pickAry;
    NSString *pickerType;
}
@end

@implementation RadarSetViewController


- (void) loadView{
    self.view = [[RadarSet alloc] init];
    self.view.tableView.delegate = self;
    self.view.tableView.dataSource = self;
    self.view.pickerview.delegate=self;
    self.view.pickerview.dataSource=self;
    [self.view.sureButton addTarget:self action:@selector(sureHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.ifUseSettedHomeSwitch addTarget: self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"雷达设置"];

    beforeAry = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    distanceAry = @[@"1000",@"1500",@"2000",@"2500",@"3000",@"3500",@"4000",@"4500",@"5000"];
    
    //设置米和天数和开关
    self.view.beforeValueLable.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"beforeDay"] stringByAppendingString:@"天"];
    self.view.distanceValueLable.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"distance"] stringByAppendingString:@"米"];
    
    [self.view.ifUseSettedHomeSwitch setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:@"ifUseSettedHome"] boolValue]];
   
    
    //设置默认设置地点为定位地址
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"settedHome"]) {
        [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"home"] forKey:@"settedHome"];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    
    //这种方法是在放回的过程中逐渐取消选中状态的，可以提示刚才点进去的是哪一行，默认的也正是这种效果
    [self.view.tableView deselectRowAtIndexPath:[self.view.tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark 各种处理方法

//设置位置事件
- (void)setLocationHandle{
    LocationSetViewController *locationSetVC = [[LocationSetViewController alloc] init];
    [self.navigationController pushViewController:locationSetVC animated:YES];
}

//设置开关
- (void) switchValueChanged:(id)sender{
    //这里写这么多判断其实就是为了确定谁是谁，可以简写
    UISwitch* control = (UISwitch*)sender;
    if(control == self.view.ifUseSettedHomeSwitch){
        [[NSUserDefaults standardUserDefaults] setBool:control.on forKey:@"ifUseSettedHome"];
    }
}

//点击完成
- (void)sureHandle{
    [self.view.tableView deselectRowAtIndexPath:[self.view.tableView indexPathForSelectedRow] animated:YES];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                        self.view.pickView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), 204);
                     }
     ];
    
    
    
}

//设置天数
- (void)setBeforeDayHandle{
    pickAry = beforeAry;
    pickerType = BEFORE_DAY_PICK;
    [self.view.pickerview reloadAllComponents];
    
    //UIVIEW得动画效果
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.pickView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)-204, CGRectGetWidth(self.view.frame), 204);
                     }
     ];
    
    
    for (int i = 0; i<pickAry.count; i++) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"beforeDay"] isEqualToString:pickAry[i]]) {
            [self.view.pickerview selectRow:i inComponent:0 animated:YES];
        }
    }
}
//设置距离
- (void)setDistanceHandle{
    pickAry = distanceAry;
    pickerType = DISTANCE_PICK;
    [self.view.pickerview reloadAllComponents];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.view.pickView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame)-204, CGRectGetWidth(self.view.frame), 204);
              }
     ];
    
       for (int i = 0; i<pickAry.count; i++) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"distance"] isEqualToString:pickAry[i]]) {
            [self.view.pickerview selectRow:i inComponent:0 animated:YES];
        }
    }
    
}

#pragma mark pickView delegate
/* return cor of pickerview*/
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
/*return row number*/
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickAry count];
}

/*return component row str*/
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickAry objectAtIndex:row];
}

/*choose com is component,row's function*/
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerType == DISTANCE_PICK) {
        [[NSUserDefaults standardUserDefaults] setObject:distanceAry[row] forKey:@"distance"];
        self.view.distanceValueLable.text=[[[NSUserDefaults standardUserDefaults] objectForKey:@"distance"] stringByAppendingString:@"米"];

    }
    
    if (pickerType == BEFORE_DAY_PICK) {
        [[NSUserDefaults standardUserDefaults] setObject:beforeAry[row] forKey:@"beforeDay"];
        self.view.beforeValueLable.text=[[[NSUserDefaults standardUserDefaults] objectForKey:@"beforeDay"] stringByAppendingString:@"天"];

    }
}


#pragma mark tableView方法
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int section = (int)indexPath.section;
    static NSString *CellIdentifier = @"setRadarCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (section) {
            case 0:
                cell.textLabel.text =  @"距离范围";
                [cell.contentView addSubview:self.view.distanceValueLable];
                break;
                
            case 1:
                cell.textLabel.text =  @"时间范围";
                [cell.contentView addSubview:self.view.beforeValueLable];
                break;
                
            case 2:
                cell.textLabel.text =  @"自定义搜索点";
                [cell.contentView addSubview:self.view.ifUseSettedHomeSwitch];
                break;
            
    
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int section = (int)indexPath.section;
    switch (section) {
        case 0:
            [self setDistanceHandle];
            break;
            
        case 1:
            [self setBeforeDayHandle];
            break;
            
        case 2:
            [self setLocationHandle];
            break;
        default:
            break;
    }
}

@end
