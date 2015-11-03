//
//  ConversationCell.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/10/29.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "Conversation.h"
@interface ConversationCell : CommonTableViewCell
@property (nonatomic, strong) Conversation *conversation;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@end
