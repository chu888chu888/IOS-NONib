//
//  UIViewAnimationDemoController.m
//  EmptyXcodeProject
//
//  Created by chuguangming on 15/5/12.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "UIViewAnimationDemoController.h"
#import "UIView-TagExtensions.h"
#define LABEL_TAG 101
@interface UIViewAnimationDemoController ()

@end

@implementation UIViewAnimationDemoController
- (void) loadView
{
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"UIViewAnimationDemoController" owner:self options:nil] lastObject];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // set the label to the current time
    [self.view.window labelWithTag:LABEL_TAG].text = [[NSDate date] description];
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
