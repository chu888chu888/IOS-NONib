//
//  ImageScrollView.h
//  ScrollViewDemo
//
//  Created by chuguangming on 15/9/24.
//  Copyright © 2015年 chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollView : UIScrollView<UIScrollViewDelegate>
{
    @private
    UIImageView * imageView;
}
@property(nonatomic,readonly,retain) UIImageView * imageView;
@end
