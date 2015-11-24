//
//  FounctionCell.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/11/19.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "TLSetting.h"
@interface FounctionCell : CommonTableViewCell
// 一般Type
@property (nonatomic, strong) SettingItem *item;
@property (nonatomic, assign) CGFloat titleFontSize;
@property (nonatomic, assign) CGFloat subTitleFontSize;
@property (nonatomic, assign) UIColor* subTitleFontColor;

// buttonType 用
@property (nonatomic, assign) UIColor *buttonTitleColor;
@property (nonatomic, assign) UIColor *buttonBackgroundGColor;

- (void) addTarget:(id)target action:(SEL)action;
@end
