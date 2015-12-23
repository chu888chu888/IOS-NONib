//
//  GistCellTableViewCell.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/18.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gists.h"
#import "CommonTableViewCell.h"
@interface GistCellTableViewCell : CommonTableViewCell
@property (nonatomic, strong) Gists *gistMsg;

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *created_at_Label;
@property (nonatomic, strong) UILabel *updated_at_Label;
@property (nonatomic, strong) UILabel *descLabel;
@end
