//
//  ForRentCallViewController.h
//  weAgent
//
//  Created by apple on 14/12/18.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalViewController.h"
#import "MJRefresh.h"

@interface CallViewController : GlobalViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) UITableView *view;
-(id)initWithTypeId:(NSString*)theTypeId;
@end