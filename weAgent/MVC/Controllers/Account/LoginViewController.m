//
//  LoginViewController.m
//  weChat
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FindPasswordViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)loadView{
    self.view = [[Login alloc] init];
    [self.view.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    self.view.passwordText.delegate =self;
    self.view.nameText.delegate =self;
    //    [self.view.registerBtn addTarget:self action:@selector(registerHandle) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view.findBtn addTarget:self action:@selector(findPasswordHandle) forControlEvents:UIControlEventTouchUpInside];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
    
    //最完成view注册手势
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    //不发送取消事件消息
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    [self.view.registerBtn addTarget:self action:@selector(registerBtnHandle) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view.findBtn addTarget:self action:@selector(findBtnHandle) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)login{
    
    //设置按钮不可用，防止重复提交
    [self.view.loginBtn setEnabled:NO];
    // Store generated call id to match up responses·
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.view.nameText.text,@"username",self.view.passwordText.text,@"password",nil];
    
    
    DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        NSString *code = [methodResult objectForKey:@"code"];
        if ([code isEqualToString:@"010101"]){
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"请输入正确格式的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.loginBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"010102"]){
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"密码格式不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.loginBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"010103"]){
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"用户不存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.loginBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"010104"]){
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.loginBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"010105"]){
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"创建证书失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.loginBtn setEnabled:YES];
            return;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[[methodResult objectForKey:@"result"] objectForKey:@"diploma"] forKey:@"diploma"];
        //这里好多if考虑重构
        if (![[[methodResult objectForKey:@"result"] objectForKey:@"avatar"] isKindOfClass:[NSString class]]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"avatar"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:[[methodResult objectForKey:@"result"] objectForKey:@"avatar"] forKey:@"avatar"];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[[methodResult objectForKey:@"result"] objectForKey:@"id"] forKey:@"id"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[[methodResult objectForKey:@"result"] objectForKey:@"username"] forKey:@"phone"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[[methodResult objectForKey:@"result"] objectForKey:@"name"] forKey:@"name"];
        
        [self.view.loginBtn setEnabled:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    
    [self RPCUseClass:@"Sessions" callMethodName:@"create" withParameters:parameters onCompletion:completionHandler];
    
}

#pragma mark textfield代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
#pragma mark 点击别的地方使输入框隐藏
-(void)viewTapped
{
    [self.view endEditing:YES];
}

#pragma mark 注册、找回密码按钮操作
-(void)registerBtnHandle{
    
    //进入注册页面
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    registerVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:registerVC animated:YES];
    
}


-(void)findBtnHandle{
    
    //进入找回密码页面
    FindPasswordViewController *findPassVC = [[FindPasswordViewController alloc] init];
    findPassVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:findPassVC animated:YES];
    
}
@end
