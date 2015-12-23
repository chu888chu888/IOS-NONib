//
//  GistsCellWithNibTableViewCell.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/23.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "GistsCellWithNibTableViewCell.h"

@implementation GistsCellWithNibTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setGistMsg:(Gists *)gistMsg
{
    _gistMsg=gistMsg;
    [_lblCreate_at_Time setText:_gistMsg.created_at];
    [_lblUpdate_at_Time setText:_gistMsg.updated_at];
}
@end
