//
//  HouseListCell.h
//  weAgent
//
//  Created by apple on 14/12/1.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+base.h"
#import "UIColor+base.h"
#import "UIView+base.h"

@interface HouseListCell : UITableViewCell
@property (nonatomic) UILabel *nameValue;
@property (nonatomic) UILabel *phoneValue;
@property (nonatomic) UIImageView *imageValue;
@property (nonatomic) UILabel *moneyLab;
@property (nonatomic) UILabel *typeLab;
@property (nonatomic) UILabel *distanceLab;
@property (nonatomic) UILabel *timeLab;
@property (nonatomic) UILabel *useLable;
@property (nonatomic) UIView *starView;
@property (nonatomic) UILabel *addressLab;
@end
