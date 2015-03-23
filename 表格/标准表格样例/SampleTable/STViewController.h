//
//  STViewController.h
//  SampleTable
//
//  Created by rjxy on 12-7-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) NSArray *listData;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UITableViewCell *tableViewCell;

@end
