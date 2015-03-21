//
//  WeVisitViewController.m
//  weAgent
//
//  Created by 王拓 on 14/11/24.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "WeVisitViewController.h"


@interface WeVisitViewController ()<ViewPagerDataSource, ViewPagerDelegate>{
    WeVisitRecommendViewController *recommendView;
    WeVisitPassViewController *passView;
}

@end

@implementation WeVisitViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.dataSource = self;
    self.delegate = self;
    recommendView = [[WeVisitRecommendViewController alloc]init];
    passView = [[WeVisitPassViewController alloc]init];
}


#pragma mark - ViewPagerDataSource


/**
 *  设置滑动页个数
 *
 *  wangtuo
 *
 *  @param viewPager
 *
 *  @return 页面个数
 */
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 2;
}


/**
 *  定义tab标签标题内容
 *
 *  wangtuo
 *
 *  @param viewPager
 *  @param index
 *
 *  @return 返回label
 */
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.0];
    switch (index) {
        case 0:
            label.text=@"精品访谈";
            break;
        case 1:
            label.text=@"往期回顾";
        default:
            break;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}


/**
 *  设置页面对应部分的颜色
 *
 *  wangtuo
 *
 *  @param viewPager
 *  @param component
 *  @param color
 *
 *  @return 返回UIColor
 */
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            //下划线颜色
            return [[UIColor baseColor] colorWithAlphaComponent:0.64];
        case ViewPagerTabsView:
            //tab标签背景颜色
            return [[UIColor lightGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
}


/**
 *  配置其他选项
 *
 *  wangtuo
 *
 *  @param viewPager
 *  @param option
 *  @param value
 *
 *  @return 返回各个选项对应值
 */
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            //设置标签是否从第二个开始
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            //设置标签是否居中
            return 0.0;
        case ViewPagerOptionTabLocation:
            //设置标签位置 1.0上 0.0下
            return 1.0;
        case ViewPagerOptionTabHeight:
            //设置标签高度
            return 49.0;
        case ViewPagerOptionTabOffset:
            //设置标签距离前面的距离
            return 0.0;
        case ViewPagerOptionTabWidth:
            //设置标签的宽度
            return [[UIScreen mainScreen] bounds].size.width*0.5;
        case ViewPagerOptionFixFormerTabsPositions:
            //设置改变选择标签时，前标签是否移动 1.0移动 0.0不移动
            return 0.0;
        case ViewPagerOptionFixLatterTabsPositions:
            //设置改变选择标签时，后标签是否移动 1.0移动 0.0不移动
            return 0.0;
        default:
            return value;
    }
}


/**
 *  设置页面内容
 *
 *  wangtuo
 *
 *  @param viewPager
 *  @param index
 *
 *  @return 返回视图控制器
 */
- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
   
    
    switch (index) {
        case 0:
            return recommendView;
            break;
        case 1:
            return passView;
            break;
        default:
            return nil;
            break;
            
    }
}


@end

