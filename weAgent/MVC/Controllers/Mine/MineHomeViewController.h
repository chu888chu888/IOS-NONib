//
//  MineHomeViewController.h
//  weChat
//
//  Created by apple on 14-9-1.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "GlobalViewController.h"
#import "MineHome.h"

@interface MineHomeViewController : GlobalViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) MineHome *view;
@end
