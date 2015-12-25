//
//  TLUser.m
//  iOSAppTemplate
//
//  Created by 李伯坤 on 15/9/16.
//  Copyright (c) 2015年 lbk. All rights reserved.
//

#import "User.h"

@implementation User

- (void) setUsername:(NSString *)username
{
    _username = username;
    _pinyin = username.pinyin;
    _initial = username.pinyinInitial;
}

@end
