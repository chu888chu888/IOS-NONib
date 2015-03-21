//
//  VersionViewController.h
//  weAgent
//
//  Created by apple on 14-10-24.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "GlobalViewController.h"
#import "IntroduceViewController.h"
#import "VersionInfoViewController.h"
#import "FeedbackViewController.h"

@interface VersionViewController : GlobalViewController<NextViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) UITableView *view;
@end
