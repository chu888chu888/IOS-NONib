//
//  FriendCell.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/11/3.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _avatarImageView = [[UIImageView alloc] init];
        [self addSubview:_avatarImageView];
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setFont:[UIFont systemFontOfSize:17.0f]];
        [self addSubview:_usernameLabel];
    }
    return self;
}

- (void) layoutSubviews
{
    self.leftFreeSpace = self.frameHeight * 0.18;
    [super layoutSubviews];
    
    float spaceX = self.frameHeight * 0.18;
    float spaceY = self.frameHeight * 0.17;
    float imageWidth = self.frameHeight - spaceY * 2;
    [_avatarImageView setFrame:CGRectMake(spaceX, spaceY, imageWidth, imageWidth)];
    
    float labelX = imageWidth + spaceX * 2;
    float labelWidth = self.frameWidth - labelX - spaceX * 1.5;
    [_usernameLabel setFrame:CGRectMake(labelX, spaceY, labelWidth, imageWidth)];
}

- (void) setUser:(User *)user
{
    [_avatarImageView setImage:[UIImage imageNamed:[NSString stringWithFormat: @"%@", user.avatarURL]]];
    [_usernameLabel setText:user.username];
}

@end
