//
//  RecommendCell.m
//  weAgent
//
//  Created by 王拓 on 14/12/1.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "RecommendCell.h"

@implementation RecommendCell

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


- (void)initialize{
    
    [self addMainContent];
    [self addTitle];
    [self addCounts];
    [self addImage];
    [self addContent];
    
}

/**
 *  添加主区域块
 */
- (void)addMainContent{
    CGFloat adjustWidth=[[UIScreen mainScreen] bounds].size.width-40.0f;
    _mainContent = [[UIView alloc]initWithFrame:CGRectMake(0, 0, adjustWidth, 280)];
    _mainContent.center=CGPointMake([[UIScreen mainScreen] bounds].size.width*0.5, 145);
    [self addSubview:_mainContent];
    
}

/**
 *  添加标题
 */
- (void)addTitle{
    CGFloat adjustWidth=[[UIScreen mainScreen] bounds].size.width-40.0f;
    _title = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 10.0f, adjustWidth*0.7, 20.0f)];
    [_title setTextColor:[UIColor grayColor]];
    [_title setFont:[UIFont fontWithName:@"Arial" size:12]];
    [_mainContent addSubview:_title];
}


/**
 *  添加阅读量标签
 */
- (void)addCounts{
    CGFloat adjustWidth=[[UIScreen mainScreen] bounds].size.width-40.0f;
    _counts=[[UILabel alloc]initWithFrame:CGRectMake(adjustWidth*0.7, 10.0f, adjustWidth*0.3, 20.0f)];
    _counts.textAlignment = NSTextAlignmentRight;

    [_counts setTextColor:[UIColor grayColor]];
    [_counts setFont:[UIFont fontWithName:@"Arial" size:12]];
    [_mainContent addSubview:_counts];
}


/**
 *  添加图片
 */
- (void)addImage{
    CGFloat adjustWidth=[[UIScreen mainScreen] bounds].size.width-40.0f;
    _image=[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 35, adjustWidth, 190)];
    [_image setBackgroundColor:[UIColor lightGrayColor]];
    [_mainContent addSubview:_image];
}

/**
 *  添加简述内容
 */
-(void)addContent{
    CGFloat adjustWidth=[[UIScreen mainScreen] bounds].size.width-40.0f;
    _content = [[UILabel alloc]initWithFrame:CGRectMake(0, 230, adjustWidth, 40)];
    [_content setFont:[UIFont fontWithName:@"Arial" size:10]];
    [_content setTextColor:[UIColor lightGrayColor]];
    [_content setNumberOfLines:0];
    [_mainContent addSubview:_content];
}
@end
