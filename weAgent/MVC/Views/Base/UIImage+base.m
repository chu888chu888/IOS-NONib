//
//  UIImage+base.m
//  weChat
//
//  Created by apple on 14-9-25.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "UIImage+base.h"

@implementation UIImage (base)
- (UIImage*)beResize{
    CGFloat top = 7; // 顶端盖高度
    CGFloat bottom = 7 ; // 底端盖高度
    CGFloat left = 7; // 左端盖宽度
    CGFloat right = 7; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    return [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

//将图片保存到本地
+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    [preferences setObject:UIImagePNGRepresentation(image) forKey:key];
}

//本地是否有相关图片
+ (BOOL)LocalHaveImage:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSData* imageData = [preferences objectForKey:key];
    if (imageData) {
        return YES;
    }
    return NO;
}

//从本地获取图片
+ (UIImage*)GetImageFromLocal:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSData* imageData = [preferences objectForKey:key];
    UIImage* image;
    if (imageData) {
        image = [UIImage imageWithData:imageData];
    }
    else {
        NSLog(@"未从本地获得图片");
    }
    return image;
}

@end
