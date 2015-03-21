//
//  LoadingView.m
//  weChat
//
//  Created by apple on 14-9-28.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

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
    [self addView];
}

-(void) addView{
    NSArray *loadingArray = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"m1"],
                             [UIImage imageNamed:@"m2"],
                             nil];
    
    
    UIImageView *loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    //    loadingImgView.contentMode =  UIViewContentModeCenter;
    loadingImgView.animationImages = loadingArray; //animationImages属性返回一个存放动画图片的数组
    loadingImgView.animationDuration = 0.2; //浏览整个图片一次所用的时间
    loadingImgView.animationRepeatCount = 0; // 0 = loops forever 动画重复次数
    [loadingImgView startAnimating];
    
    self.linearLayoutItem = [CSLinearLayoutItem layoutItemForView:loadingImgView];
    self.linearLayoutItem.padding = CSLinearLayoutMakePadding(([UIView globalHeight]-300)/2, 0.0, 0.0, 0.0);
    self.linearLayoutItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:self.linearLayoutItem];
    
    UILabel *LoadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIView globalWidth], 14)];
    LoadingLabel.text = @"正在为您玩命加载数据...";
    LoadingLabel.font = [UIFont baseWithSize:12.0];
    LoadingLabel.textAlignment = NSTextAlignmentCenter;
    self.linearLayoutItem = [CSLinearLayoutItem layoutItemForView:LoadingLabel];
    self.linearLayoutItem.padding = CSLinearLayoutMakePadding(10.0, 0.0, 0.0, 0.0);
    [self.linearLayoutView addItem:self.linearLayoutItem];
  
}

@end
