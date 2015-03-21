//
//  SecondHousesTableViewController.h
//  weChat
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "GlobalViewController.h"
#import "MJRefresh.h"
#import "UIimageView+AFNetworking.h"
#import "RadarList.h"
#import "SecondFiltrateViewController.h"

@interface SecondHousesTableViewController : GlobalViewController<UITableViewDataSource,UITableViewDelegate,FiltrateDelegate>

@property (nonatomic) RadarList *view;
- (void)beginFiltrate;
@end

