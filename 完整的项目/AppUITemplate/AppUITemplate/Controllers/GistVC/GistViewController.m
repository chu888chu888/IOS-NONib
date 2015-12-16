//
//  GistViewController.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/16.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "GistViewController.h"
#import "GistDataSource.h"
@interface GistViewController ()

@end

@implementation GistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setHidesBottomBarWhenPushed:YES];
    // Do any additional setup after loading the view.
    GistDataSourceCompletionBlock completionBlock=^(NSArray * data,NSString *errorString)
    {
        if (data!=nil) {
            NSLog(@"data is ok");
        }
        else
        {
            NSLog(@"data is error");
        }
    };
    GistDataSource *source=[GistDataSource discoverSource];
    [source getGistList:nil completion:completionBlock];
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
