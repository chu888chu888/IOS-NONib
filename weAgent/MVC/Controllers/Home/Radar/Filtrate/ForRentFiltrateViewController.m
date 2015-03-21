//
//  ForRentFiltrateViewController.m
//  weAgent
//
//  Created by 王拓 on 14/12/8.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "ForRentFiltrateViewController.h"

@interface ForRentFiltrateViewController ()

@end

@implementation ForRentFiltrateViewController

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
    self.moneyMaxText.text = self.moneyMaxText.text?self.moneyMaxText.text:@"0";
    self.moneyMinText.text = self.moneyMinText.text?self.moneyMinText.text:@"0";
    self.distanceMaxText.text = self.distanceMaxText.text?self.distanceMaxText.text:@"0";
    self.distanceMinText.text = self.distanceMinText.text?self.distanceMinText.text:@"0";
    
    NSString *temp ;
    
    if ([self.moneyMaxText.text floatValue]< [self.moneyMinText.text floatValue]) {
        temp = self.moneyMinText.text;
        self.moneyMinText.text = self.moneyMaxText.text;
        self.moneyMaxText.text = temp;
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
            return @"价格区间";
            break;

        case 1:
            return @"求租类型";
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
    switch (section) {
        case 1:
            return 3;
            break;
        default:
            return 1;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
                    _moneyMinText = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 10.0, 60, 26)];
                    _moneyMinText.returnKeyType = UIReturnKeyDone;
                    _moneyMinText.keyboardType = UIKeyboardTypeNumberPad;
                    [_moneyMinText beGreen];
                    [cell.contentView addSubview:_moneyMinText];
                    
                    UILabel *yuanTextOne = [[UILabel alloc] initWithFrame:CGRectMake(80.0, 10.0, 40, 26)];
                    yuanTextOne.text = @"元 —";
                    [cell.contentView addSubview:yuanTextOne];
                    
                    _moneyMaxText = [[UITextField alloc] initWithFrame:CGRectMake(130.0, 10.0, 60, 26)];
                    _moneyMaxText.returnKeyType = UIReturnKeyDone;
                    _moneyMaxText.keyboardType = UIKeyboardTypeNumberPad;
                    [_moneyMaxText beGreen];
                    [cell.contentView addSubview:_moneyMaxText];
                    
                    UILabel *yuanTextTwo = [[UILabel alloc] initWithFrame:CGRectMake(200.0, 10.0, 30, 26)];
                    yuanTextTwo.text = @"元";
                    [cell.contentView addSubview:yuanTextTwo];
                }
                break;
                

            case 1:
                if(row == 0)
                {
                    cell.textLabel.text =  @"整租";
                    
                }
                if(row == 1)
                {
                    cell.textLabel.text =  @"合租";
                    
                }
                if(row == 2){
                    cell.textLabel.text =  @"不限";
                }
                
                break;
                
            default:
                cell.textLabel.text =  @"";
                break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = (int)indexPath.row;
    int section = (int)indexPath.section;

    UITableViewCell *cell = [self.view.listView cellForRowAtIndexPath: indexPath];
    
    //遍历所有的可见行
    NSArray *array = [self.view.listView visibleCells];
    for (UITableViewCell *cell in array) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    
    
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
                self.rentType = @"1";
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
            if(row == 1)
            {
                self.rentType = @"2";
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
            if(row == 2)
            {
                self.rentType = @"0";
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
            break;
            
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
