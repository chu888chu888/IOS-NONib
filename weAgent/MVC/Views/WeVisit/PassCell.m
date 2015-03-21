//
//  PassCell.m
//  weAgent
//
//  Created by 王拓 on 14/12/2.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "PassCell.h"

@implementation PassCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)initialize{
    
    [self addMainContent];
    [self addHeadImage];
    [self addTitle];
    [self addSubTitle];
    [self addCounts];
    
}

-(void)addMainContent{
    
    _mainContent = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.width, 100)];
    [self addSubview:_mainContent];
    
}

-(void)addHeadImage{
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20.0f, 10.0f, 80.0f, 80.0f)];
    [_headImage setBackgroundColor:[UIColor lightGrayColor]];
    [_mainContent addSubview:_headImage];
}

-(void)addTitle{
    CGFloat adjustWidth=[[UIScreen mainScreen] bounds].size.width-140.0f;
    _title = [[UILabel alloc]initWithFrame:CGRectMake(120.0f, 10.0f, adjustWidth, 20.0f)];
    [_title setFont:[UIFont fontWithName:@"Arial" size:17]];
    [_mainContent addSubview:_title];
}

-(void)addSubTitle{
    CGFloat adjustWidth=[[UIScreen mainScreen] bounds].size.width-140.0f;
    _subTitle = [[UILabel alloc]initWithFrame:CGRectMake(120.0f, 35.0f, adjustWidth, 40.0f)];
    [_subTitle setTextColor:[UIColor lightGrayColor]];
    [_subTitle setNumberOfLines:0];
    [_subTitle setFont:[UIFont fontWithName:@"Arial" size:11]];
    [_mainContent addSubview:_subTitle];
    
}

-(void)addCounts{
    _counts = [[UILabel alloc]initWithFrame:CGRectMake(120.0f, 78.0f, 70.0f, 12.0f)];
    [_counts setTextColor:[UIColor lightGrayColor]];
    [_counts setFont:[UIFont fontWithName:@"Arial" size:11]];
    
    [_mainContent addSubview:_counts];
}
@end
