//
//  HouseListCell.m
//  weAgent
//
//  Created by apple on 14/12/1.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "HouseListCell.h"



@implementation HouseListCell

@synthesize imageValue;
@synthesize nameValue;
@synthesize phoneValue;
@synthesize useLable;
@synthesize moneyLab;
@synthesize typeLab;
@synthesize distanceLab;
@synthesize timeLab;
@synthesize addressLab;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    imageValue = [[UIImageView alloc] initWithFrame:CGRectMake(6, 3 ,60 , 60)];
    [self.contentView addSubview:imageValue];
    
    nameValue = [[UILabel alloc] initWithFrame:CGRectMake(82, 3 ,70 , 20)];
    nameValue.textColor = [UIColor grayColor];
    [self.contentView addSubview:nameValue];
    
    phoneValue = [[UILabel alloc] initWithFrame:CGRectMake(152, 3 ,200 , 20)];
    phoneValue.textColor = [UIColor orangeColor];
    [self.contentView addSubview:phoneValue];
    
    useLable = [[UILabel alloc] initWithFrame:CGRectMake(82, 23 ,50 , 20)];
    useLable.textColor = [UIColor lightGrayColor];
    useLable.text = @"可用度 :";
    useLable.font = [UIFont baseWithSize:12];
    [self.contentView addSubview:useLable];
    
    _starView = [[UIView alloc] initWithFrame:CGRectMake(132, 23 ,200 , 20)];
    [self.contentView addSubview:_starView];
    
    
    [self addBottomLab];
    
    
    
}


- (void)addBottomLab{
    float labWidth = ([UIView globalWidth] - 100)/4;
    
    moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(82 , 43 ,labWidth , 20)];
    moneyLab.textColor = [UIColor orangeColor];
    moneyLab.text = @"1000";
    moneyLab.font = [UIFont baseWithSize:12];
    [self.contentView addSubview:moneyLab];
    
    typeLab = [[UILabel alloc] initWithFrame:CGRectMake(82 + labWidth, 43 ,labWidth , 20)];
    typeLab.textColor = [UIColor grayColor];
    typeLab.text = @"合租";
    typeLab.font = [UIFont baseWithSize:12];
    [self.contentView addSubview:typeLab];
    
    distanceLab = [[UILabel alloc] initWithFrame:CGRectMake(82 + 2*labWidth, 43 ,labWidth , 20)];
    distanceLab.textColor = [UIColor grayColor];
    distanceLab.text = @"6000米";
    distanceLab.font = [UIFont baseWithSize:12];
    [self.contentView addSubview:distanceLab];
    
    timeLab = [[UILabel alloc] initWithFrame:CGRectMake(82 + 3*labWidth, 43 ,labWidth , 20)];
    timeLab.textColor = [UIColor grayColor];
    timeLab.text = @"今天";
    timeLab.font = [UIFont baseWithSize:12];
    [self.contentView addSubview:timeLab];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
