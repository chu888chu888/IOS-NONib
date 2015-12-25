//
//  CommonTableViewCell.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/10/29.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CellLineStyle)
{
    CellLineStyleDefault,
    CellLineStyleFill,
    CellLineStyleNone,
};
@interface CommonTableViewCell : UITableViewCell
@property(nonatomic,strong) UIView *topLine;
@property(nonatomic,strong) UIView *bottomLine;
@property(nonatomic,assign) float leftFreeSpace;

@property(nonatomic,assign) CellLineStyle bottomLineStyle;
@property(nonatomic,assign) CellLineStyle topLineStyle;
@end
