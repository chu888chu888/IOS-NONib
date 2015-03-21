//
//  UIColor+base.m
//  weChat
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "UIColor+base.h"

@implementation UIColor (base)
+ (UIColor *)baseBackgroundColor{
    return [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
}

+ (UIColor *)baseColor{
    return [UIColor colorWithRed:15/255.0 green:172/255.0 blue:237/255.0 alpha:1];
}

+ (UIColor *)goodDarkColor{
    return [UIColor colorWithRed:64/255.0 green:71/255.0 blue:85/255.0 alpha:1];
}

/**
 *  根据十六进制颜色生成UIColor
 *
 *  @param color 十六进制颜色字符串
 *
 *  @return 返回UIColor
 */
+ (UIColor *) colorWithHexString: (NSString *)color{
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    
}
@end
