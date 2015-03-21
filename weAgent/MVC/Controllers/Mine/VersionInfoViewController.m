//
//  VersionInfoViewController.m
//  weAgent
//
//  Created by 王拓 on 14/12/11.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "VersionInfoViewController.h"

@interface VersionInfoViewController ()

@end

@implementation VersionInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[VersionInfo alloc]init];
    self.title = @"版本说明";
    
    
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
