//
//  MyZoomViewController.m
//  ScrollViewDemo
//
//  Created by chuguangming on 15/9/22.
//  Copyright © 2015年 chu. All rights reserved.
//

#import "MyZoomViewController.h"
#import "ImageScrollView.h"
@interface MyZoomViewController ()

@end

@implementation MyZoomViewController
-(void)loadView
{
    [super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
    scrollView.backgroundColor=[UIColor clearColor];
    //scrollView.minimumZoomScale=0.5;
    //scrollView.maximumZoomScale=6;
    scrollView.contentSize=CGSizeMake(375*4, 667);
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    /*
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
    imageView.image=[UIImage imageNamed:@"5.jpg"];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    [scrollView addSubview:imageView];
     */
    
    int x=0;
    for (int index=0; index<4; index++) {
        ImageScrollView *imgScrollView=[[ImageScrollView alloc] initWithFrame:CGRectMake(0+x, 0, 375, 557)];
        NSString *imgName=[NSString stringWithFormat:@"%d.jpg",index+1];
        imgScrollView.imageView.image=[UIImage imageNamed:imgName];
        [scrollView addSubview:imgScrollView];
        x+=375;
    }

}
#pragma mark -UIScrollView Delegate
//返回一个放大或者缩小的视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}
//开始缩小或者放大
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"开始缩放");
}
//缩放结束时
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"缩放结束");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
