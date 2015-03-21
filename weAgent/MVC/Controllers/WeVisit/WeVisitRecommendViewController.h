//
//  WeVisitRecommendViewController.h
//  weAgent
//
//  Created by 王拓 on 14/11/27.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalViewController.h"
#import "WeVisitRecommend.h"

@interface WeVisitRecommendViewController : GlobalViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic) WeVisitRecommend *view;

@end
