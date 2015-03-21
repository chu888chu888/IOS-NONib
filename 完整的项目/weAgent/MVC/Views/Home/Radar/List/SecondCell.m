//
//  SecondCell.m
//  weAgent
//
//  Created by 王拓 on 14/12/10.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "SecondCell.h"

@implementation SecondCell

@synthesize moneyLab;
@synthesize addressLab;
@synthesize timeLab;
@synthesize housetypeLab;


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)addBottomLab{
    
    float labWidth = ([UIView globalWidth] - 100)/4;
    
    moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(82 , 43 ,labWidth , 20)];
    moneyLab.textColor = [UIColor orangeColor];
    moneyLab.text = @"1000元";
    moneyLab.font = [UIFont baseWithSize:12];
    [self.contentView addSubview:moneyLab];
    
    addressLab = [[UILabel alloc]initWithFrame:CGRectMake(82 + labWidth, 43, labWidth, 20)];
    addressLab.font = [UIFont baseWithSize:12];
    addressLab.textColor = [UIColor grayColor];
    [self.contentView addSubview:addressLab];
    
    housetypeLab = [[UILabel alloc]initWithFrame:CGRectMake(82 + labWidth*1.9, 43, labWidth*1.3, 20)];
    housetypeLab.font = [UIFont baseWithSize:12];
    housetypeLab.textColor = [UIColor grayColor];
    [self.contentView addSubview:housetypeLab];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(82 + 3.2*labWidth, 43 ,labWidth , 20)];
    timeLab.textColor = [UIColor grayColor];
    timeLab.text = @"今天";
    timeLab.font = [UIFont baseWithSize:12];
    [self.contentView addSubview:timeLab];
}

@end
