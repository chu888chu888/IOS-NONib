//
//  PickerDemoViewController.h
//  ScrollViewDemo
//
//  Created by chuguangming on 15/10/21.
//  Copyright © 2015年 chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerDemoViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    //用于存储省份-城市数据
    NSDictionary *dict;
    //省份数据
    NSArray *provinceArray;
    //城市数据
    NSArray *cityArray;
    
    UIPickerView *pickerView;
    
    NSString *selectedProvince;
    NSString *selectedCity;
    NSInteger selectedCityIndex;
    NSInteger selectedProvinceIndex;
    
}
@end
