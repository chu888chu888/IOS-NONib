//
//  ImageScrollView.m
//  ScrollViewDemo
//
//  Created by chuguangming on 15/9/24.
//  Copyright © 2015年 chu. All rights reserved.
//

#import "ImageScrollView.h"

@implementation ImageScrollView
@synthesize imageView;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.maximumZoomScale=3;
        self.minimumZoomScale=1;
        
        //添加图片
        imageView=[[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imageView];
        //设置代理
        self.delegate=self;
    }
    return self;
}
#pragma mark UIScrollView Delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}
@end
