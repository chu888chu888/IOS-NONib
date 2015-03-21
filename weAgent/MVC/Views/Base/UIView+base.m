//
//  UIView+base.m
//  weAgent
//
//  Created by apple on 14/11/27.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "UIView+base.h"

@implementation UIView (base)
+ (float) globalWidth{
    return  [ UIScreen mainScreen ].applicationFrame.size.width;
}
+ (float) globalHeight{
    return  [ UIScreen mainScreen ].applicationFrame.size.height;
}

@end
