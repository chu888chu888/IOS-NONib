//
//  FirstViewController.m
//  CustomeCellTable
//
//  Created by chuguangming on 15/1/28.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize lblUserAge,lblUserName,lblUserPhone;
@synthesize txtUserAge,txtUserName,txtUserPhone;
@synthesize btnAdd;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.view setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view.
    lblUserName=[[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 50)];
    lblUserName.text=@"UserName:";
    lblUserName.textAlignment=UITextAlignmentRight;
    lblUserName.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:lblUserName];
    
    lblUserAge=[[UILabel alloc] initWithFrame:CGRectMake(0, 110, 100, 50)];
    lblUserAge.text=@"UserAge:";
    lblUserAge.textAlignment=UITextAlignmentRight;
    lblUserAge.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:lblUserAge];
    
    lblUserPhone=[[UILabel alloc] initWithFrame:CGRectMake(0, 160, 100, 50)];
    lblUserPhone.text=@"UserPhone:";
    lblUserPhone.textAlignment=UITextAlignmentRight;
    lblUserPhone.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:lblUserPhone];
    
    txtUserName=[[UITextField alloc] initWithFrame:CGRectMake(100, 65, 200, 35)];
    [txtUserName setBorderStyle:UITextBorderStyleRoundedRect];
    txtUserName.returnKeyType = UIReturnKeyDone;
    txtUserName.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [self.view addSubview:txtUserName];
    
    txtUserAge=[[UITextField alloc] initWithFrame:CGRectMake(100, 115, 200, 35)];
    [txtUserAge setBorderStyle:UITextBorderStyleRoundedRect];
    txtUserAge.returnKeyType = UIReturnKeyDone;
    txtUserAge.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [self.view addSubview:txtUserAge];
    
    txtUserPhone=[[UITextField alloc] initWithFrame:CGRectMake(100, 165, 200, 35)];
    [txtUserPhone setBorderStyle:UITextBorderStyleRoundedRect];
    txtUserPhone.returnKeyType = UIReturnKeyDone;
    txtUserPhone.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [self.view addSubview:txtUserPhone];
    
    btnAdd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnAdd.frame = CGRectMake(0, 200, 100, 35);
    [btnAdd setTitle:@"添加" forState:UIControlStateNormal];
    [self.view addSubview:btnAdd];
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
