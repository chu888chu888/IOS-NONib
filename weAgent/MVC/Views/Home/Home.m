//
//  Home.m
//  weAgent
//
//  Created by 王拓 on 14/11/24.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "Home.h"

@implementation Home

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _screenWidth=[[UIScreen mainScreen]bounds].size.width;
        [self initialize];
    }
    return self;
}


/**
 *  初始化页面
 *
 *  wangtuo
 */
- (void)initialize{
    
    //调用方法添加页面元素
    [self addAdView];
    [self addSearchView];
    [self addButtonBlock];
    [self addNoNetView];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"help_one"]) {
        [self addHelpView];
    }

    
}


/**
 *  添加广告轮播
 *
 *  wangtuo
 */
-(void)addAdView{
    
    //初始化imagePager
    _imagePager = [[KIImagePager alloc] init];
    float adHeight = [UIView globalHeight]/4;
    _imagePager.frame = CGRectMake(0.0f, 0.0f, [UIView globalWidth], adHeight);
    _imagePager.captionBackgroundColor = [UIColor clearColor];
    
    //使用线性布局放置
    CSLinearLayoutItem *imagePagerItem = [CSLinearLayoutItem layoutItemForView:_imagePager];
    imagePagerItem.padding = CSLinearLayoutMakePadding(0.0f, 0.0f, 0.0f, 0.0f);
    imagePagerItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:imagePagerItem];
    
}


/**
 *  添加搜索按键区
 *
 *  wangtuo
 */
-(void)addSearchView{
    
    //初始化外层区域，并使用线性布局放置
    _searchView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, [UIView globalWidth], 16)];
    
    //添加距离范围、时间范围标签
    UILabel *distanceLab = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 0.0f, 60.0f, 16.0f)];
    distanceLab.font=[UIFont fontWithName:@"Helvetica" size:12];
    distanceLab.text=@"距离范围：";
    distanceLab.textColor=[UIColor grayColor];
    [_searchView addSubview:distanceLab];
    
    _distanceValueLab = [[UILabel alloc]initWithFrame:CGRectMake(75.0f, 0.0f, 40.0f, 16.0f)];
    _distanceValueLab.font=[UIFont fontWithName:@"Helvetica" size:12];
    _distanceValueLab.text=@"∞米";
    _distanceValueLab.textColor=[UIColor baseColor];
    [_searchView addSubview:_distanceValueLab];
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(125.0f, 0.0f, 60.0f, 16.0f)];
    timeLab.font=[UIFont fontWithName:@"Helvetica" size:12];
    timeLab.text=@"时间范围：";
    timeLab.textColor=[UIColor grayColor];
    [_searchView addSubview:timeLab];
    
    _timeValueLab = [[UILabel alloc]initWithFrame:CGRectMake(185.0f, 0.0f, 40.0f, 16.0f)];
    _timeValueLab.font=[UIFont fontWithName:@"Helvetica" size:12];
    _timeValueLab.text=@"∞天";
    _timeValueLab.textColor=[UIColor baseColor];
    [_searchView addSubview:_timeValueLab];
    
    self.linearLayoutItem = [CSLinearLayoutItem layoutItemForView:_searchView];
    self.linearLayoutItem.padding = CSLinearLayoutMakePadding(5.0f, 0.0, 0.0, 0.0);
    self.linearLayoutItem.horizontalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
    [self.linearLayoutView addItem:self.linearLayoutItem];

    
    //初始化外层区域，并使用线性布局放置
    UIView *searchButtonView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, [UIView globalWidth], 40)];
    //添加一键搜索按钮
    _radarBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIView globalWidth]-155, 5.0f, 140.0f, 34.0f)];
    [_radarBtn setTitle:@"一键         搜索" forState:UIControlStateNormal];
    _radarBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [_radarBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _radarBtn.layer.borderWidth = 1.0;
    // 设置颜色空间为rgb，用于生成ColorRef
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 0.8, 0.8, 0.8, 1 });
    _radarBtn.layer.borderColor = borderColorRef;
    [_radarBtn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
    //添加雷达标志
    UIImageView *radarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radar"]];
    radarView.frame = CGRectMake(60.0f, 7.0f, 20, 20);
    [_radarBtn addSubview:radarView];
    [searchButtonView addSubview:_radarBtn];
    

    _searchLab = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, 5.0f, 120.0f, 34.0f)];
    _searchLab.font=[UIFont fontWithName:@"Helvetica" size:12];
    _searchLab.text=@"点击进入雷达搜索";
    _searchLab.textColor=[UIColor baseColor];
    [searchButtonView addSubview:_searchLab];
    
    self.linearLayoutItem = [CSLinearLayoutItem layoutItemForView:searchButtonView];
    self.linearLayoutItem.padding = CSLinearLayoutMakePadding(0.0f, 0.0, 0.0, 0.0);
    self.linearLayoutItem.horizontalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
    [self.linearLayoutView addItem:self.linearLayoutItem];

    
}


/**
 *  添加按钮区域
 *
 *  wangtuo
 *
 *  实现上依次添加每一个按钮，前期比较易读容易维护，之后代码重构可以考录使用循环实现。
 */
- (void)addButtonBlock{
    
    //计算正方形按钮长宽
    CGFloat buttonLenth=_screenWidth*0.33333;
    
    //初始化按钮区域并添加
    _buttonBlock=[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _screenWidth, buttonLenth*2)];
    CSLinearLayoutItem *buttonBlockItem = [CSLinearLayoutItem layoutItemForView:_buttonBlock];
    buttonBlockItem.padding = CSLinearLayoutMakePadding(10.0f, 0.0, 0.0, 0.0);
    buttonBlockItem.horizontalAlignment = CSLinearLayoutItemVerticalAlignmentCenter;
    [self.linearLayoutView addItem:buttonBlockItem];
    
    //求组房按钮
    _homeWantedBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, buttonLenth, buttonLenth)];
    [_homeWantedBtn setImage:[UIImage imageNamed:@"home-want.png"] forState:UIControlStateNormal];
    _homeWantedBtn.imageEdgeInsets = UIEdgeInsetsMake(-25, 20, 0, -50);
    [_homeWantedBtn setTitle:@"求租房客" forState:UIControlStateNormal];
    _homeWantedBtn.titleEdgeInsets = UIEdgeInsetsMake(15, -40, -30, 0);
    [_homeWantedBtn setBackgroundColor:[UIColor colorWithHexString:@"#87daf9"]];
    [_buttonBlock addSubview:_homeWantedBtn];
    
    //添加数字
    _wantedNum = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 5.0f, buttonLenth-10, 14)];
    _wantedNum.font=[UIFont fontWithName:@"Helvetica" size:14];
    _wantedNum.text=@"∞";
    _wantedNum.textAlignment= NSTextAlignmentRight;
    _wantedNum.textColor=[UIColor whiteColor];
    [_homeWantedBtn addSubview:_wantedNum];
    
    //出租房按钮
    _homeRentBtn = [[UIButton alloc]initWithFrame:CGRectMake(buttonLenth, 0.0f, buttonLenth, buttonLenth)];
//    [_homeRentBtn setImage:[UIImage imageNamed:@"home_rent.png"] forState:UIControlStateNormal];
    [_homeRentBtn setImage:[UIImage imageNamed:@"home-rent.png"] forState:UIControlStateNormal];
    _homeRentBtn.imageEdgeInsets = UIEdgeInsetsMake(-25, 20, 0, -50);
    [_homeRentBtn setTitle:@"出租房源" forState:UIControlStateNormal];
    _homeRentBtn.titleEdgeInsets = UIEdgeInsetsMake(15, -40, -30, 0);
    [_homeRentBtn setBackgroundColor:[UIColor colorWithHexString:@"#b2e7fb"]];
    [_buttonBlock addSubview:_homeRentBtn];
    
    //添加数字
    _rentNum = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 5.0f, buttonLenth-10, 14)];
    _rentNum.font=[UIFont fontWithName:@"Helvetica" size:14];
    _rentNum.text=@"∞";
    _rentNum.textAlignment= NSTextAlignmentRight;
    _rentNum.textColor=[UIColor whiteColor];
    [_homeRentBtn addSubview:_rentNum];
    
    //二手房源按钮
    _homeSecondBtn = [[UIButton alloc]initWithFrame:CGRectMake(buttonLenth*2, 0.0f, buttonLenth, buttonLenth)];
    [_homeSecondBtn setImage:[UIImage imageNamed:@"home-second.png"] forState:UIControlStateNormal];
    _homeSecondBtn.imageEdgeInsets = UIEdgeInsetsMake(-25, 20, 0, -50);
    [_homeSecondBtn setTitle:@"二手房源" forState:UIControlStateNormal];
    _homeSecondBtn.titleEdgeInsets = UIEdgeInsetsMake(15, -40, -30, 0);
    [_homeSecondBtn setBackgroundColor:[UIColor colorWithHexString:@"#81aae3"]];
    [_buttonBlock addSubview:_homeSecondBtn];
    
    //添加数字
    _secondNum = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 5.0f, buttonLenth-10, 14)];
    _secondNum.font=[UIFont fontWithName:@"Helvetica" size:14];
    _secondNum.text=@"∞";
    _secondNum.textAlignment= NSTextAlignmentRight;
    _secondNum.textColor=[UIColor whiteColor];
    [_homeSecondBtn addSubview:_secondNum];
    
    //客户收藏按钮
    _homeCollectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, buttonLenth, buttonLenth, buttonLenth)];
    [_homeCollectBtn setImage:[UIImage imageNamed:@"home-collect.png"] forState:UIControlStateNormal];
    _homeCollectBtn.imageEdgeInsets = UIEdgeInsetsMake(-25, 20, 0, -50);
    [_homeCollectBtn setTitle:@"客户收藏" forState:UIControlStateNormal];
    _homeCollectBtn.titleEdgeInsets = UIEdgeInsetsMake(15, -40, -30, 0);
    [_homeCollectBtn setBackgroundColor:[UIColor colorWithHexString:@"#bae17a"]];
    [_buttonBlock addSubview:_homeCollectBtn];
    
    //我的业绩按钮
    _homeAchieveBtn = [[UIButton alloc]initWithFrame:CGRectMake(buttonLenth, buttonLenth, buttonLenth, buttonLenth)];
    [_homeAchieveBtn setImage:[UIImage imageNamed:@"home-achieve.png"] forState:UIControlStateNormal];
    _homeAchieveBtn.imageEdgeInsets = UIEdgeInsetsMake(-25, 20, 0, -50);
    [_homeAchieveBtn setTitle:@"我的业绩" forState:UIControlStateNormal];
    _homeAchieveBtn.titleEdgeInsets = UIEdgeInsetsMake(15, -40, -30, 0);
    [_homeAchieveBtn setBackgroundColor:[UIColor colorWithHexString:@"#77ce66"]];
    [_buttonBlock addSubview:_homeAchieveBtn];
    
    //设置按钮
    _homeSetBtn = [[UIButton alloc]initWithFrame:CGRectMake(buttonLenth*2, buttonLenth, buttonLenth, buttonLenth)];
    [_homeSetBtn setImage:[UIImage imageNamed:@"home-set.png"] forState:UIControlStateNormal];
    _homeSetBtn.imageEdgeInsets = UIEdgeInsetsMake(-25, 20, 0, -20);
    [_homeSetBtn setTitle:@"设置" forState:UIControlStateNormal];
    _homeSetBtn.titleEdgeInsets = UIEdgeInsetsMake(15, -32, -30, 0);
    [_homeSetBtn setBackgroundColor:[UIColor colorWithHexString:@"#f78374"]];
    [_buttonBlock addSubview:_homeSetBtn];
    
}

- (void) addNoNetView {
    //初始化外层区域，并使用线性布局放置
    _noNetView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, [UIView globalWidth], 40)];
    _noNetView.backgroundColor = [UIColor colorWithHexString:@"#fff3bb"];
    
    UILabel *noNetLab = [[UILabel alloc] initWithFrame:CGRectMake(64, 10, 270, 20)];
    noNetLab.font = [UIFont baseWithSize:14];
    noNetLab.text = @"当前网络不可用，请检查你的网络设置";
    noNetLab.textColor = [UIColor grayColor];
    [_noNetView addSubview:noNetLab];
    
    UIImageView *tanView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tanhao"]];
    tanView.frame = CGRectMake(20.0f, 8.0f, 24, 24);
    [_noNetView addSubview:tanView];
    
    [self addSubview:_noNetView];
    
    [self.linearLayoutView setFrame:CGRectMake(self.linearLayoutView.frame.origin.x, self.linearLayoutView.frame.origin.y + 40, self.linearLayoutView.frame.size.width, self.linearLayoutView.frame.size.height)];
}



-(void) addHelpView{
    _helpView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, [UIView globalWidth], 548)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, [UIView globalWidth], [UIView globalHeight])];
    [imageView setImage:[UIImage imageNamed:@"help"]];
    [_helpView addSubview:imageView];
    
    _helpBtn = [[UIButton alloc]initWithFrame:CGRectMake(50 ,[UIView globalHeight]*0.45, 110, 38)];
    [_helpBtn setBackgroundImage:[UIImage imageNamed:@"helpBtn"] forState:UIControlStateNormal];
    [_helpView addSubview:_helpBtn];
    
    [self addSubview:_helpView];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"help_one"];
}

@end
