//
//  PickerDemoViewController.m
//  ScrollViewDemo
//
//  Created by chuguangming on 15/10/21.
//  Copyright © 2015年 chu. All rights reserved.
//

#import "PickerDemoViewController.h"

@interface PickerDemoViewController ()

@end

@implementation PickerDemoViewController

- (void)initPicker {
    // Do any additional setup after loading the view.
    
    pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 667-216, 0, 0)];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    pickerView.showsSelectionIndicator=YES;
    [self.view addSubview:pickerView];
    
    NSBundle *bundle=[NSBundle mainBundle];
    NSString * plistPath=[bundle pathForResource:@"provinces_cities" ofType:@"plist"];
    dict=[[NSDictionary alloc]initWithContentsOfFile:plistPath];
    provinceArray=[dict allKeys];
    
    NSInteger selectedProvinceIndex=[pickerView selectedRowInComponent:0];
    NSString *selectedProvince=[provinceArray objectAtIndex:selectedProvinceIndex];
    cityArray=[dict objectForKey:selectedProvince];
    NSLog(@"省份数量%lu",(unsigned long)[provinceArray count]);
    NSLog(@"当前省份的城市%@",cityArray);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPicker];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -Datasource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [provinceArray count];
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return [provinceArray count];
    }
    return [cityArray count];
}

//确定每个轮子显示的内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0)
    {
        return [provinceArray objectAtIndex:row];
    }
    else
    {
        return [cityArray objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component==0)
    {

        selectedProvince=[provinceArray objectAtIndex:row];
        cityArray=[dict objectForKey:selectedProvince];
        //重点,更新第二个轮子的数据
        [pickerView reloadComponent:1];
        selectedCityIndex=[pickerView selectedRowInComponent:1];
        selectedCity=[cityArray objectAtIndex:selectedCityIndex];
        NSString *msg=[NSString stringWithFormat:@"省:%@,市:%@",selectedProvince,selectedCity];
        NSLog(@"%@",msg);
    }
    else
    {
        selectedProvinceIndex=[pickerView selectedRowInComponent:0];
        selectedProvince=[provinceArray objectAtIndex:selectedProvinceIndex];
        selectedCity=[cityArray objectAtIndex:row];
        NSString *msg=[NSString stringWithFormat:@"省:%@,市:%@",selectedProvince,selectedCity];
        NSLog(@"%@",msg);
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
