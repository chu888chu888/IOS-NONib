//
//  RentTableViewController.h
//  weChat
//
//  Created by apple on 14-9-1.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "GlobalViewController.h"
#import "MJRefresh.h"
#import "UIimageView+AFNetworking.h"
#import "RadarList.h"
#import "HouseFiltrateViewController.h"
@interface RentTableViewController : GlobalViewController<UITableViewDataSource,UITableViewDelegate,FiltrateDelegate>

@property (nonatomic) RadarList *view;
- (void)beginFiltrate;
@end
