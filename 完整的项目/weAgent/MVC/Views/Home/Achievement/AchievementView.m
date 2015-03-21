//
//  Achievement.m
//  weChat
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "AchievementView.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"

@implementation AchievementView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    [self addRateView];
    [self addGraphView];
    [self addNumView];
       
}

- (void)addRateView{
    
    MDRadialProgressTheme *newTheme = [[MDRadialProgressTheme alloc] init];
    newTheme.completedColor = [UIColor colorWithRed:73/255.0 green:185/255.0 blue:101/255.0 alpha:1.0];
    newTheme.incompletedColor = [UIColor colorWithRed:224/255.0 green:85/255.0 blue:91/255.0 alpha:1.0];
    newTheme.centerColor = [UIColor clearColor];
    newTheme.thickness = 10;
//    newTheme.centerColor = [UIColor colorWithRed:224/255.0 green:248/255.0 blue:216/255.0 alpha:1.0];
    newTheme.sliceDividerHidden = YES;
    newTheme.labelColor = [UIColor redColor];
    newTheme.font = [UIFont baseWithSize:30];
    newTheme.labelColor = [UIColor blackColor];
    newTheme.labelShadowColor = [UIColor whiteColor];
    
    
    UIView *rateView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth], [UIView globalWidth]/3+60)];
   
    _dayRadialView = [[MDRadialProgressView alloc] initWithFrame: CGRectMake(30, 10, [UIView globalWidth]/3, [UIView globalWidth]/3) andTheme:newTheme];
    _dayRadialView.label.textColor = [UIColor colorWithRed:224/255.0 green:85/255.0 blue:91/255.0 alpha:1.0];
    _dayRadialView.progressTotal = 100;
    _dayRadialView.progressCounter = 1;
    _dayRadialView.labelTextBlock = ^(MDRadialProgressView *progressView){
        return [[NSString stringWithFormat:@"%lu",(unsigned long)progressView.progressCounter] stringByAppendingString:@"%"];
    };
    [rateView addSubview:_dayRadialView];
    
    _monthRadialView = [[MDRadialProgressView alloc] initWithFrame: CGRectMake([UIView globalWidth]/2+30, 10, [UIView globalWidth]/3, [UIView globalWidth]/3) andTheme:newTheme];
    _monthRadialView.progressTotal = 100;
    _monthRadialView.progressCounter = 1;
    _monthRadialView.label.textColor = [UIColor colorWithRed:224/255.0 green:85/255.0 blue:91/255.0 alpha:1.0];
    _monthRadialView.labelTextBlock = ^(MDRadialProgressView *progressView){
        return [[NSString stringWithFormat:@"%lu",(unsigned long)progressView.progressCounter] stringByAppendingString:@"%"];
    };
    [rateView addSubview:_monthRadialView];
    
    UILabel *dayRadialLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0, [UIView globalWidth]/3+20, [UIView globalWidth]/2, 18)];
    dayRadialLable.text = @"今日我战胜了";
    dayRadialLable.textAlignment = NSTextAlignmentCenter;
    dayRadialLable.font = [UIFont baseWithSize:14];
    dayRadialLable.textColor = [UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1.0];
    [rateView addSubview:dayRadialLable];
    
    UILabel *monthRadialLable = [[UILabel alloc] initWithFrame:CGRectMake([UIView globalWidth]/2, [UIView globalWidth]/3+20, [UIView globalWidth]/2, 18)];
    monthRadialLable.text = @"本月我战胜了";
    monthRadialLable.textAlignment = NSTextAlignmentCenter;
    monthRadialLable.font = [UIFont baseWithSize:14];
    monthRadialLable.textColor = [UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1.0];
    [rateView addSubview:monthRadialLable];
    
    
    CSLinearLayoutItem *rateViewGraphItem = [CSLinearLayoutItem layoutItemForView:rateView];
    rateViewGraphItem.padding = CSLinearLayoutMakePadding(0.0, 0.0, 0.0, 0.0);
    rateViewGraphItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:rateViewGraphItem];
    
}
- (void)addGraphView
{
    UILabel *graphTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth], 18)];
    graphTitle.text = @"近期客户量走势图";
    graphTitle.textAlignment = NSTextAlignmentCenter;
    graphTitle.font = [UIFont baseWithSize:16];
    graphTitle.textColor = [UIColor baseColor];
    
    CSLinearLayoutItem *graphTitleItem = [CSLinearLayoutItem layoutItemForView:graphTitle];
    graphTitleItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 0.0);
    graphTitleItem.horizontalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
    [self.linearLayoutView addItem:graphTitleItem];
    
    
    _achievementGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth], [UIView globalHeight]/3)];
    _achievementGraph.colorTop = [UIColor baseColor];
    _achievementGraph.colorBottom = [UIColor baseColor];
    _achievementGraph.colorLine = [UIColor whiteColor];
    _achievementGraph.colorXaxisLabel = [UIColor whiteColor];
    _achievementGraph.colorYaxisLabel = [UIColor whiteColor];
    _achievementGraph.widthLine = 3.0;
    _achievementGraph.enableTouchReport = YES;
    _achievementGraph.enablePopUpReport = YES;
    _achievementGraph.enableBezierCurve = NO;
    _achievementGraph.enableYAxisLabel = YES;
    _achievementGraph.autoScaleYAxis = YES;
    _achievementGraph.alwaysDisplayDots = NO;
    _achievementGraph.enableReferenceXAxisLines = YES;
    _achievementGraph.enableReferenceYAxisLines = YES;
    _achievementGraph.enableReferenceAxisFrame = YES;
    _achievementGraph.animationGraphStyle = BEMLineAnimationDraw;
    
   
    CSLinearLayoutItem *achievementGraphItem = [CSLinearLayoutItem layoutItemForView:_achievementGraph];
    achievementGraphItem.padding = CSLinearLayoutMakePadding(10.0, 0.0, 0.0, 0.0);
    achievementGraphItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:achievementGraphItem];

}

- (void)addNumView
{
    
    UILabel *thisWeek = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth]/3, 18)];
    thisWeek.text = @"本周";
    thisWeek.textAlignment = NSTextAlignmentCenter;
    thisWeek.font = [UIFont baseWithSize:20];
    thisWeek.textColor = [UIColor grayColor];
   
    UILabel *today = [[UILabel alloc] initWithFrame:CGRectMake([UIView globalWidth]/3, 0.0, [UIView globalWidth]/3, 18)];
    today.text = @"今日";
    today.textAlignment = NSTextAlignmentCenter;
    today.font = [UIFont baseWithSize:20];
    today.textColor = [UIColor grayColor];
   
    UILabel *total = [[UILabel alloc] initWithFrame:CGRectMake([UIView globalWidth]/3*2, 0.0, [UIView globalWidth]/3, 18)];
    total.text = @"总计";
    total.textAlignment = NSTextAlignmentCenter;
    total.font = [UIFont baseWithSize:20];
    total.textColor = [UIColor grayColor];
    
    UIView *numLableView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth], 18)];
    [numLableView addSubview:thisWeek];
    [numLableView addSubview:today];
    [numLableView addSubview:total];

    CSLinearLayoutItem *numLableViewItem = [CSLinearLayoutItem layoutItemForView:numLableView];
    numLableViewItem.padding = CSLinearLayoutMakePadding(20.0, 0.0, 0.0, 0.0);
    numLableViewItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:numLableViewItem];

    
    
    _thisWeekNum = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth]/3, 18)];
    _thisWeekNum.text = @"200";
    _thisWeekNum.textAlignment = NSTextAlignmentCenter;
    _thisWeekNum.font = [UIFont baseWithSize:18];
    _thisWeekNum.textColor = [UIColor orangeColor];
    
    _todayNum = [[UILabel alloc] initWithFrame:CGRectMake([UIView globalWidth]/3, 0.0, [UIView globalWidth]/3, 18)];
    _todayNum.text = @"10";
    _todayNum.textAlignment = NSTextAlignmentCenter;
    _todayNum.font = [UIFont baseWithSize:18];
    _todayNum.textColor = [UIColor orangeColor];
    
    _totalNum = [[UILabel alloc] initWithFrame:CGRectMake([UIView globalWidth]/3*2, 0.0, [UIView globalWidth]/3, 18)];
    _totalNum.text = @"1000";
    _totalNum.textAlignment = NSTextAlignmentCenter;
    _totalNum.font = [UIFont baseWithSize:18];
    _totalNum.textColor = [UIColor orangeColor];
    
    UIView *numView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth], 18)];
    [numView addSubview:_thisWeekNum];
    [numView addSubview:_todayNum];
    [numView addSubview:_totalNum];
    
    CSLinearLayoutItem *numViewItem = [CSLinearLayoutItem layoutItemForView:numView];
    numViewItem.padding = CSLinearLayoutMakePadding(10.0, 0.0, 0.0, 0.0);
    numViewItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:numViewItem];
    
}



@end
