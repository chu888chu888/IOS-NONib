//
//  MyZoomViewController.h
//  ScrollViewDemo
//
//  Created by chuguangming on 15/9/22.
//  Copyright © 2015年 chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyZoomViewController : UIViewController<UIScrollViewDelegate>
{
@private
    UIScrollView *scrollView;
    UIImageView  *imageView;
}
@end