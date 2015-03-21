//
//  NSConditionViewController.h
//  KCMainViewDemo
//
//  Created by chuguangming on 15/3/11.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSConditionViewController : UIViewController
#pragma mark 图片资源存储容器
@property (atomic,strong) NSMutableArray *imageNames;

#pragma mark 当前加载的图片索引（图片链接地址连续）
@property (atomic,assign) int currentIndex;
@end
