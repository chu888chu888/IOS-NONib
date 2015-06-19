//
//  AddServerViewController.m
//  DigitalOcean
//
//  Created by chuguangming on 15/5/7.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "AddServerViewController.h"
#import "CSLinearLayoutView.h"
#import "UIColor+RandomColor.h"
@interface AddServerViewController ()
@end

@implementation AddServerViewController
- (void)InitNav {
    //在右侧添加按钮
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:nil action:nil];
    self.navigationItem.rightBarButtonItem=rightItem;
}

- (void)InitLayout {
    self.VlinearLayoutView = [[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    _VlinearLayoutView.orientation = CSLinearLayoutViewOrientationVertical;
    _VlinearLayoutView.scrollEnabled = YES;
    _VlinearLayoutView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _VlinearLayoutView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_VlinearLayoutView];
    
    self.HlinearLayoutView=[[CSLinearLayoutView alloc] initWithFrame:self.view.bounds];
    _HlinearLayoutView.orientation=CSLinearLayoutViewOrientationHorizontal;
    _HlinearLayoutView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _HlinearLayoutView.backgroundColor = [UIColor whiteColor];
    [_VlinearLayoutView addSubview:_HlinearLayoutView];
    
    
    
    // add a description label
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.font = [UIFont systemFontOfSize:16.0];
    descriptionLabel.text = @"Token ID:";
    descriptionLabel.frame = CGRectMake(0.0, 0.0, 70, 44);
    
    CSLinearLayoutItem *labelItem = [CSLinearLayoutItem layoutItemForView:descriptionLabel];
    labelItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    labelItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentLeft;
    [_HlinearLayoutView addItem:labelItem];
    
    
    UITextField *servertextField=[[UITextField alloc] init];
    servertextField.frame=CGRectMake(0, 0, 260.0, 44);
    servertextField.borderStyle=UITextBorderStyleRoundedRect;
    servertextField.text=@"";
    
    CSLinearLayoutItem *servertextFieldItem=[CSLinearLayoutItem layoutItemForView:servertextField];
    servertextFieldItem.padding=CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    servertextFieldItem.horizontalAlignment=CSLinearLayoutItemHorizontalAlignmentCenter;
    [_HlinearLayoutView addItem:servertextFieldItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // setup the linear layout
    
    
    [self InitNav];
    
    [self InitLayout];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
