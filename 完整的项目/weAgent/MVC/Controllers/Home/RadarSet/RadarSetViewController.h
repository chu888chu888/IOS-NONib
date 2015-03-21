//
//  SetRadarViewController.h
//  weAgent
//
//  Created by apple on 14-10-23.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "GlobalViewController.h"
#import "RadarSet.h"
@interface RadarSetViewController : GlobalViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic) RadarSet *view;
@end
