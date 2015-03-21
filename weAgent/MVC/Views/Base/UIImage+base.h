//
//  UIImage+base.h
//  weChat
//
//  Created by apple on 14-9-25.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (base)
- (UIImage*)beResize;
//将图片保存到本地
+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key;
//本地是否有相关图片
+ (BOOL)LocalHaveImage:(NSString*)key;
//从本地获取图片
+ (UIImage*)GetImageFromLocal:(NSString*)key;
@end
