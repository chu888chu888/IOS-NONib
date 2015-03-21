//
//  ForRentCell.m
//  weAgent
//
//  Created by 王拓 on 14/12/8.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "ForRentCell.h"

@implementation ForRentCell
@synthesize moneyLab;
@synthesize addressLab;
@synthesize timeLab;


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)addBottomLab{

    float labWidth = ([UIView globalWidth] - 105)/3;
    
    moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(82 , 43 ,labWidth , 20)];
    moneyLab.textColor = [UIColor orangeColor];
    moneyLab.text = @"1000";
    moneyLab.font = [UIFont baseWithSize:12];
    [self.contentView addSubview:moneyLab];
    
    addressLab = [[UILabel alloc]initWithFrame:CGRectMake(82 + labWidth, 43, labWidth*1.5, 20)];
    addressLab.font = [UIFont baseWithSize:12];
    addressLab.textColor = [UIColor grayColor];
    [self.contentView addSubview:addressLab];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(82 + 2.5*labWidth, 43 ,labWidth , 20)];
    timeLab.textColor = [UIColor grayColor];
    timeLab.text = @"今天";
    timeLab.font = [UIFont baseWithSize:12];
    [self.contentView addSubview:timeLab];
}
@end
