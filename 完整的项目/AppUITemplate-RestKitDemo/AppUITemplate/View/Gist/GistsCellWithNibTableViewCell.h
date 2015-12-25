//
//  GistsCellWithNibTableViewCell.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/23.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gists.h"
@interface GistsCellWithNibTableViewCell : UITableViewCell
@property (nonatomic, strong) Gists *gistMsg;
@property (weak, nonatomic) IBOutlet UILabel *lblCreate_at_Time;
@property (weak, nonatomic) IBOutlet UILabel *lblUpdate_at_Time;

@end
