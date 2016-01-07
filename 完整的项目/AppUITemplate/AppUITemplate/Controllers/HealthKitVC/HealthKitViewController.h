//
//  HealthKitViewController.h
//  AppUITemplate
//
//  Created by 楚广明 on 16/1/7.
//  Copyright © 2016年 楚广明. All rights reserved.
//

#import <UIKit/UIKit.h>
@import HealthKit;
#import "HealthKitHelper.h"

@interface HealthKitViewController : UIViewController
@property (nonatomic) HKHealthStore *healthStore;
@property (nonatomic) HealthKitHelper *HLKHelper;
@property (weak, nonatomic) IBOutlet UILabel *heightUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightValueLabel;

@end
