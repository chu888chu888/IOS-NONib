//
//  Home.h
//  weAgent
//
//  Created by 王拓 on 14/11/24.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalUIView.h"
#import "KIImagePager.h"

@interface Home : GlobalUIView

@property(nonatomic) CGFloat screenWidth;

@property (nonatomic) KIImagePager *imagePager;

@property (nonatomic) UIButton *radarBtn;
@property (nonatomic) UILabel *distanceValueLab;
@property (nonatomic) UILabel *timeValueLab;
@property (nonatomic) UILabel *searchLab;
@property (nonatomic) UILabel *wantedNum;
@property (nonatomic) UILabel *rentNum;
@property (nonatomic) UILabel *secondNum;


@property(nonatomic) UIView *buttonBlock;
@property(nonatomic) UIButton *homeWantedBtn;
@property(nonatomic) UIButton *homeRentBtn;
@property(nonatomic) UIButton *homeSecondBtn;
@property(nonatomic) UIButton *homeCollectBtn;
@property(nonatomic) UIButton *homeAchieveBtn;
@property(nonatomic) UIButton *homeSetBtn;

@property(nonatomic) UIView *noNetView;

@property(nonatomic) UIView *searchView;
@property(nonatomic) UIView *helpView;
@property(nonatomic) UIButton *helpBtn;

- (void) addNoNetView;

@end
