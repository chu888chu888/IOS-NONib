//
//  CustomerViewController.m
//  weAgent
//
//  Created by apple on 14/12/10.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "CustomerViewController.h"
#import "UIColor+base.h"
#import "UIView+base.h"
#import "ForRentCustomerTableViewController.h"
#import "RentCustomerTableViewController.h"
#import "SecondCustomerTableViewController.h"
@interface CustomerViewController ()<ViewPagerDataSource, ViewPagerDelegate,UIGestureRecognizerDelegate>{
    ForRentCustomerTableViewController *forRentCustomerView;
    RentCustomerTableViewController *rentCustomerView;
    SecondCustomerTableViewController  *secondCustomerView;
    CGRect tempTabBarFrame;
}

@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"收藏客户"];
    self.dataSource = self;
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //这句话很重要，虽然设置了tabar隐藏，但是有些控件还是会把tabbar高度计算进去，导致出现莫名其妙得44像素空白
    tempTabBarFrame = self.tabBarController.tabBar.frame;
    self.tabBarController.tabBar.frame  = CGRectMake(0, 0, 0, 0);
    forRentCustomerView = [[ForRentCustomerTableViewController alloc]init];
    rentCustomerView = [[RentCustomerTableViewController alloc]init];
    secondCustomerView = [[SecondCustomerTableViewController alloc]init];
    
    //禁用翻页效果
    self.pageViewController.dataSource = nil;
    
}

-(void) viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.frame  = tempTabBarFrame;
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
    return 3;
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
            label.text=@"求租";
            break;
        case 1:
            label.text=@"出租";
            break;
        case 2:
            label.text=@"二手";
            break;
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
            return [[UIScreen mainScreen] bounds].size.width/3;
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
            return forRentCustomerView;
            break;
        case 1:
            return rentCustomerView;
            break;
        case 2:
            return secondCustomerView;
            break;
        default:
            return nil;
            break;
    }
}

@end
