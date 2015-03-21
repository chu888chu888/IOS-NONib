//
//  SecondFiltrateViewController.m
//  weAgent
//
//  Created by 王拓 on 14/12/10.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "SecondFiltrateViewController.h"

@interface SecondFiltrateViewController ()

@end

@implementation SecondFiltrateViewController


-(void)loadView {
    self.view = [[HouseFiltrate alloc] init];
    self.view.listView.dataSource = self;
    self.view.listView.delegate = self;
    [self.view.completeBtn addTarget:self action:@selector(completeBtnHandle) forControlEvents:UIControlEventTouchUpInside];
    self.rentType = @"0";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"筛选";
    [self addCancelButton];
    
    //点击空白区域，键盘隐藏
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    //不发送取消事件消息
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
}

#pragma mark 点击处理
-(void) completeBtnHandle{
    self.areaMaxText.text = self.areaMaxText.text?self.areaMaxText.text:@"0";
    self.areaMinText.text = self.areaMinText.text?self.areaMinText.text:@"0";
    self.distanceMaxText.text = self.distanceMaxText.text?self.distanceMaxText.text:@"0";
    self.distanceMinText.text = self.distanceMinText.text?self.distanceMinText.text:@"0";
    
    NSString *temp ;
    
    if ([self.areaMaxText.text floatValue]< [self.areaMinText.text floatValue]) {
        temp = self.areaMinText.text;
        self.areaMinText.text = self.areaMaxText.text;
        self.areaMaxText.text = temp;
    }
    
    if ([self.distanceMaxText.text floatValue]< [self.distanceMinText.text floatValue]) {
        temp = self.distanceMinText.text;
        self.distanceMinText.text = self.distanceMaxText.text;
        self.distanceMaxText.text = temp;
    }
    
    [self backHandle];
    [self.filtrateDelegate beginFiltrate];
}


#pragma mark table处理
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"面积区间";
            break;
            
        case 1:
            return @"距离范围";
            break;
        default:
            return @"测试";
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    switch (section) {
//        case 1:
//            return 3;
//            break;
//        default:
//            return 1;
//            break;
//    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
    static NSString *CellIdentifier = @"versionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        switch (section) {
            case 0:
                if(row == 0)
                {
                    _areaMinText = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 10.0, 60, 26)];
                    _areaMinText.returnKeyType = UIReturnKeyDone;
                    _areaMinText.keyboardType = UIKeyboardTypeNumberPad;
                    [_areaMinText beGreen];
                    [cell.contentView addSubview:_areaMinText];
                    
                    UILabel *yuanTextOne = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 10.0, 70, 26)];
                    yuanTextOne.text = @"平米 —";
                    [cell.contentView addSubview:yuanTextOne];
                    
                    _areaMaxText = [[UITextField alloc] initWithFrame:CGRectMake(145.0, 10.0, 60, 26)];
                    _areaMaxText.returnKeyType = UIReturnKeyDone;
                    _areaMaxText.keyboardType = UIKeyboardTypeNumberPad;
                    [_areaMaxText beGreen];
                    [cell.contentView addSubview:_areaMaxText];
                    
                    UILabel *yuanTextTwo = [[UILabel alloc] initWithFrame:CGRectMake(215.0, 10.0, 50, 26)];
                    yuanTextTwo.text = @"平米";
                    [cell.contentView addSubview:yuanTextTwo];
                }
                break;
                
                
            case 1:
                if(row == 0)
                {
                    _distanceMinText = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 10.0, 60, 26)];
                    _distanceMinText.returnKeyType = UIReturnKeyDone;
                    _distanceMinText.keyboardType = UIKeyboardTypeNumberPad;
                    [_distanceMinText beGreen];
                    [cell.contentView addSubview:_distanceMinText];
                    
                    UILabel *yuanTextOne = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 10.0, 40, 26)];
                    yuanTextOne.text = @"米 —";
                    [cell.contentView addSubview:yuanTextOne];
                    
                    _distanceMaxText = [[UITextField alloc] initWithFrame:CGRectMake(130.0, 10.0, 60, 26)];
                    _distanceMaxText.returnKeyType = UIReturnKeyDone;
                    _distanceMaxText.keyboardType = UIKeyboardTypeNumberPad;
                    [_distanceMaxText beGreen];
                    [cell.contentView addSubview:_distanceMaxText];
                    
                    UILabel *yuanTextTwo = [[UILabel alloc] initWithFrame:CGRectMake(200.0, 10.0, 30, 26)];
                    yuanTextTwo.text = @"米";
                    [cell.contentView addSubview:yuanTextTwo];
                }
                break;                break;
                
            default:
                cell.textLabel.text =  @"";
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = (int)indexPath.row;
    int section = (int)indexPath.section;
    
    switch (section) {
        case 0:
            if(row == 0)
            {
                //                [self update];
                
            }
            
            break;
            
        case 1:
            if(row == 0)
            {
                //                [self update];
                
            }
            
        default:
            break;
    }
    
    
}

#pragma mark 点击别的地方使输入框隐藏
-(void)viewTapped
{
    [self.view endEditing:YES];
}

@end
