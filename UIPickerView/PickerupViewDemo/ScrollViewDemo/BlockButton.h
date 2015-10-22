//
//  BlockButton.h
//  ScrollViewDemo
//
//  Created by chuguangming on 15/10/20.
//  Copyright © 2015年 chu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BlockButton;
typedef void(^TouchBlock)(BlockButton *);

@interface BlockButton : UIButton
@property(nonatomic,copy)TouchBlock block;
@end
