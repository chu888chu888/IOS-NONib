//
//  VersionInfo.m
//  weAgent
//
//  Created by 王拓 on 14/12/11.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "VersionInfo.h"

@implementation VersionInfo

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize {
    
    UIView *content = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 280.0f, 160.0f)];

    
    
    UIImageView *logoImg = [[UIImageView alloc]initWithFrame:CGRectMake(90.0f, 0.0f, 100.0f, 100.0f)];
    [logoImg setImage:[UIImage imageNamed:@"logo"]];
    [content addSubview:logoImg];
    
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 115.0f, 100.0f, 20.0f)];
    nameLab.text=@"微中介";
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    nameLab.textColor=[UIColor grayColor];
    [content addSubview:nameLab];
    
    
    UILabel *versionLab = [[UILabel alloc]initWithFrame:CGRectMake(90.0f, 135.0f, 100.0f, 20.0f)];
    versionLab.text=@"版本号v1.2.0";
    versionLab.textAlignment = NSTextAlignmentCenter;
    versionLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    versionLab.textColor=[UIColor lightGrayColor];
    [content addSubview:versionLab];

    UILabel *copyRightLab = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 155.0f, 270.0f, 20.0f)];
    copyRightLab.text=@"©2014-2016 818fang.com All rights reserved.";
    copyRightLab.textAlignment = NSTextAlignmentCenter;
    copyRightLab.font = [UIFont fontWithName:@"Helvetica" size:12];
    copyRightLab.textColor=[UIColor lightGrayColor];
    [content addSubview:copyRightLab];
    
    content.center=CGPointMake([UIView globalWidth]*0.5, [UIView globalHeight]*0.5-100);
    [self addSubview:content];
    
}

@end
