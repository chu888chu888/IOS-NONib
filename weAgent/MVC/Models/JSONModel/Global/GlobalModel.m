//
//  GlobalModel.m
//  weAgent
//
//  Created by apple on 14-10-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GlobalModel.h"

@implementation GlobalModel

//所有的属性都是可选的，缺省（null）也不回报错
//所有的属性都被忽略：
//+(BOOL)propertyIsIgnored:(NSString*)propertyName;
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


@end
