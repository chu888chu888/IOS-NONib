//
//  HomeViewController.h
//  weAgent
//
//  Created by 王拓 on 14/11/24.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalViewController.h"
#import "Home.h"

@interface HomeViewController : GlobalViewController<KIImagePagerDelegate, KIImagePagerDataSource,BMKLocationServiceDelegate>

@property (nonatomic) Home *view;
@property (nonatomic) NSTimer *repeatingTimer;
@property (strong, nonatomic) NSMutableArray *photoArray;

@end
