//
//  Achievement.h
//  weChat
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "GlobalUIView.h"
#import "BEMSimpleLineGraphView.h"
#import "MDRadialProgressView.h"
@interface AchievementView : GlobalUIView
@property (strong, nonatomic) BEMSimpleLineGraphView *achievementGraph;
@property (strong, nonatomic) MDRadialProgressView *dayRadialView;
@property (strong, nonatomic) MDRadialProgressView *monthRadialView;
@property (strong, nonatomic) UILabel *thisWeekNum;
@property (strong, nonatomic) UILabel *todayNum;
@property (strong, nonatomic) UILabel *totalNum;
@end
