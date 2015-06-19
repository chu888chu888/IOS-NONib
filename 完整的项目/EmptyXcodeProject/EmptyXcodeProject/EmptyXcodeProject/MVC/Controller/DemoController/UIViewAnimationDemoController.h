//
//  UIViewAnimationDemoController.h
//  EmptyXcodeProject
//
//  Created by chuguangming on 15/5/12.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, RAFDetailViewControllerMode)
{
    RAFDetailViewControllerMode_ShakeHorizontal,
    RAFDetailViewControllerMode_ShakeVertical,
    RAFDetailViewControllerMode_Pulse,
    RAFDetailViewControllerMode_MotionEffects,
    RAFDetailViewControllerMode_Rotate,
    RAFDetailViewControllerMode_Flip,
};
@interface UIViewAnimationDemoController : UIViewController
@property(nonatomic, assign) RAFDetailViewControllerMode mode;
@end
