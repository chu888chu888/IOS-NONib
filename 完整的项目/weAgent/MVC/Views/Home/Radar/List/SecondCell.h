//
//  SecondCell.h
//  weAgent
//
//  Created by 王拓 on 14/12/10.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "HouseListCell.h"

@interface SecondCell : HouseListCell

-(void)addBottomLab;
@property (nonatomic) UILabel *moneyLab;
@property (nonatomic) UILabel *addressLab;
@property (nonatomic) UILabel *timeLab;
@property (nonatomic) UILabel *housetypeLab;

@end
