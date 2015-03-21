//
//  ForRentCell.h
//  weAgent
//
//  Created by 王拓 on 14/12/8.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HouseListCell.h"

@interface ForRentCell : HouseListCell

-(void)addBottomLab;
@property (nonatomic) UILabel *moneyLab;
@property (nonatomic) UILabel *addressLab;
@property (nonatomic) UILabel *timeLab;
@end
