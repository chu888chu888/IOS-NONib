//
//  RootViewController.m
//  ScrollViewDemo
//
//  Created by chuguangming on 15/9/17.
//  Copyright © 2015年 chu. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

-(void) loadView
{
    [super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, 480, 250)];
    scrollView.backgroundColor=[UIColor redColor];
    scrollView.contentSize=CGSizeMake(480*5, 250);
    [self.view addSubview:scrollView];
    
    UILabel *lblTest=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 480, 40)];
    lblTest.backgroundColor=[UIColor blueColor];
    lblTest.text=@"学习";
    [scrollView addSubview:lblTest];
    scrollView.delegate=self;
    

    
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
