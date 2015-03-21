//
//  ChangePasswordViewController.m
//  weAgent
//
//  Created by 王拓 on 14/12/16.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[ChangePassword alloc]init];
    [self.view.findBtn addTarget:self action:@selector(commitInfo) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commitInfo{
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    NSString *oldPassword = self.view.passwordOldText.text;
    NSString *newPassword = self.view.passwordText.text;
    NSString *againPassword = self.view.passwordAgainText.text;
    
    if ([phone isEqualToString:@""] || phone == nil) {
        self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"请登录后再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [self.MainService.promptAlert show];
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.5f];
        return;
    }
    
    //生成参数
    NSDictionary *NSDparameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:phone,@"phone",oldPassword,@"oldPassword",newPassword,@"newPassword",againPassword,@"passwordAgain",nil];
    
    
    DSJSONRPCCompletionHandler changeCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            
            NSString *code = [methodResult objectForKey:@"code"];
            
            if ([code isEqualToString:@"020401"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"不正确的手机号码，请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                return;
            }
            
            if ([code isEqualToString:@"020402"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"手机号码未注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                return;
            }
            
            if ([code isEqualToString:@"020403"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"不正确的密码格式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                return;
            }
            
            if ([code isEqualToString:@"020404"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"新密码与确认密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                return;
            }
            
            if ([code isEqualToString:@"020405"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"旧密码填写不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                return;
            }
            
            if ([code isEqualToString:@"020406"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"密码修改失败，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                return;
            }
            
            if ([code isEqualToString:@"020400"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"修改密码成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.5f];
                return;
            }
            
            
        };
        
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
        
    };
    
    [self RPCUseClass:@"Tenants" callMethodName:@"changePassword" withParameters:NSDparameters onCompletion:changeCompletionHandler];
    
    
}

- (void)delayMethod {
    [self.navigationController popViewControllerAnimated:YES];
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
