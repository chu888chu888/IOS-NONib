//
//  WeVisitPassViewController.h
//  weAgent
//
//  Created by 王拓 on 14/11/27.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalViewController.h"
#import "WeVisitPass.h"
#import "WeVisitDetailViewController.h"

@interface WeVisitPassViewController : GlobalViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic) WeVisitPass *view;

@end
