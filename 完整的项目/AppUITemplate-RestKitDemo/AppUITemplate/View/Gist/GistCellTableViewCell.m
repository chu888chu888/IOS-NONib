//
//  GistCellTableViewCell.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/18.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "GistCellTableViewCell.h"

@implementation GistCellTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _avatarImageView = [[UIImageView alloc] init];
        [_avatarImageView.layer setMasksToBounds:YES];
        [_avatarImageView.layer setCornerRadius:5.0f];
        [self addSubview:_avatarImageView];
        
        _created_at_Label=[[UILabel alloc]init];
        [_created_at_Label setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:_created_at_Label];
        
        _updated_at_Label=[[UILabel alloc]init];
        [_updated_at_Label setAlpha:0.8];
        [_updated_at_Label setFont:[UIFont systemFontOfSize:12]];
        [_updated_at_Label setTextAlignment:NSTextAlignmentRight];
        [_updated_at_Label setTextColor:[UIColor grayColor]];
        [self addSubview:_updated_at_Label];
        
        _descLabel = [[UILabel alloc] init];
        [_descLabel setTextColor:[UIColor grayColor]];
        [_descLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:_descLabel];
        
    }
    return self;
}
- (void) layoutSubviews
{

    
    [super layoutSubviews];

    [_avatarImageView setFrame:CGRectMake(0, 0, 40, 40)];

    [_created_at_Label setFrame:CGRectMake(20, 20, 40, 10)];

    [_descLabel setFrame:CGRectMake(50, 50, 100, 200)];
}
-(void)setGistMsg:(Gists *)gistMsg
{
    _gistMsg=gistMsg;
    //需要改,会堵塞线程
    NSURL *imageUrl = [NSURL URLWithString:@"https://avatars.githubusercontent.com/u/16379715?v=3"];
    //[_avatarImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]]];
    [_created_at_Label setText:_gistMsg.created_at];
    [_updated_at_Label setText:_gistMsg.gistid];
    [_descLabel setText:_gistMsg.gistid];
}
@end
