//
//  CusTomeServiceUIView.m
//  weChat
//
//  Created by apple on 14-9-17.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "CustomeService.h"

@implementation CustomeService

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void)initialize{
    
    //简单方式添加界面，后期需重构代码，提取重复代码
  
    _ServiceOne = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 10.0f, [UIView globalWidth], 150)];
    _ServiceOne.tag = 1;
    
    [self addSubview:_ServiceOne];
    _ServiceOne.backgroundColor=[UIColor baseBackgroundColor];
    UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 300, 90)];
    contentView.userInteractionEnabled=NO;
    UIImageView *serviceImgOne=[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0, 90, 90)];
    [serviceImgOne setBackgroundColor:[UIColor lightGrayColor]];
    [serviceImgOne.layer setCornerRadius:serviceImgOne.frame.size.height/2];
    [serviceImgOne setContentMode:UIViewContentModeScaleAspectFill];
    [serviceImgOne setClipsToBounds:YES];
    serviceImgOne.layer.borderColor=[[UIColor baseColor]CGColor];
    serviceImgOne.layer.borderWidth=4.0f;
    
    serviceImgOne.image=[UIImage imageNamed:@"manager_wang.png"];
    
    [contentView addSubview:serviceImgOne];
    
    UILabel *nameOne = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 0.0, 60, 30)];
    nameOne.text=@"王宁";
    [contentView addSubview:nameOne];
    
    UILabel *phoneOne = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 30.0, 200, 30)];
    phoneOne.text=@"电话:18012685169";
    phoneOne.font=[UIFont baseWithSize:14];
    
    [contentView addSubview:phoneOne];
    
    UILabel *mailOne = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 55.0, 200, 30)];
    mailOne.text=@"邮箱:wangning@818fang.com";
    mailOne.font=[UIFont baseWithSize:14];
    [contentView addSubview:mailOne];
    
    contentView.center=CGPointMake([UIView globalWidth]*0.5, _ServiceOne.frame.size.height*0.5);
    [_ServiceOne addSubview:contentView];
    
    
    _ServiceTwo = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 170.0f, [UIView globalWidth], 150)];
    _ServiceTwo.tag=2;
    [self addSubview:_ServiceTwo];
    
    _ServiceTwo.backgroundColor=[UIColor baseBackgroundColor];
    UIView *contentViewTwo=[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 300, 90)];
    contentViewTwo.userInteractionEnabled=NO;
    UIImageView *serviceImgTwo=[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0, 90, 90)];
    [serviceImgTwo setBackgroundColor:[UIColor lightGrayColor]];
    [serviceImgTwo.layer setCornerRadius:serviceImgTwo.frame.size.height/2];
    serviceImgTwo.layer.borderColor=[[UIColor baseColor]CGColor];
    serviceImgTwo.layer.borderWidth=4.0f;
    [serviceImgTwo setContentMode:UIViewContentModeScaleAspectFill];
    [serviceImgTwo setClipsToBounds:YES];
    
    serviceImgTwo.image=[UIImage imageNamed:@"manager_feng.png"];
    
    [contentViewTwo addSubview:serviceImgTwo];
    
    UILabel *nameTwo = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 0.0, 60, 30)];
    nameTwo.text=@"冯子轩";
    [contentViewTwo addSubview:nameTwo];
    
    UILabel *phoneTwo = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 30.0, 200, 30)];
    phoneTwo.text=@"电话:15262699832";
    phoneTwo.font=[UIFont baseWithSize:14];
    
    [contentViewTwo addSubview:phoneTwo];
    
    UILabel *mailTwo = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 55.0, 200, 30)];
    mailTwo.text=@"邮箱:fengzixuan@818fang.com";
    mailTwo.font=[UIFont baseWithSize:14];
    [contentViewTwo addSubview:mailTwo];
    
    contentViewTwo.center=CGPointMake([UIView globalWidth]*0.5, _ServiceTwo.frame.size.height*0.5);
    [_ServiceTwo addSubview:contentViewTwo];

}


@end
