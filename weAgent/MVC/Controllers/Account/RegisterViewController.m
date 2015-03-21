//
//  RegisterViewController.m
//  weChat
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "RootViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)loadView{

    self.view = [[Register alloc] init];
    //注册按钮点击时间
    [self.view.codeBtn addTarget:self action:@selector(codeHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.registerBtn addTarget:self action:@selector(registerHandle) forControlEvents:UIControlEventTouchUpInside];
    //按钮倒计时时间初始化
    _seconds=60;
    
    //点击空白区域，键盘隐藏
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    //不发送取消事件消息
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"注册";

}
/**
 *  获取验证码
 */
- (void)codeHandle
{
    //初始化并获取填写的手机号码
    _phone = [[NSString alloc]init];
    _phone=self.view.phoneText.text;
    
    //获取验证码请求条件
    NSDictionary *requestPhone = [NSDictionary dictionaryWithObjectsAndKeys:_phone ,@"requestPhone",@"register",@"type",nil];
    
    
        DSJSONRPCCompletionHandler requestPhoneCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
            
            //保存验证码
            NSString *code = [methodResult objectForKey:@"code"];
            
            if ([code isEqualToString:@"020101"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"获取验证码失败，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                return;
            }
            if ([code isEqualToString:@"020102"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"手机号码格式不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                return;
            }
            if ([code isEqualToString:@"020103"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"手机号码已注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                return;
            }
            if ([code isEqualToString:@"020100"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"验证码发送成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                _requestCode =[methodResult objectForKey:@"result"];
                
                //添加按钮倒计时
                NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
                
                return;
            }
            
        };

    //请求获取验证码的方法
    [self RPCUseClass:@"Tenants" callMethodName:@"captcha" withParameters:requestPhone onCompletion:requestPhoneCompletionHandler];

}

/**
 *  验证码按钮倒计时
 *
 *  @param theTimer
 */
-(void)timerFireMethod:(NSTimer *)theTimer {
    if (_seconds == 1) {
        [theTimer invalidate];
        _seconds = 60;
        [self.view.codeBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
        [self.view.codeBtn setEnabled:YES];
    }else{
        _seconds--;
        NSString *title = [NSString stringWithFormat:@"%i 秒",_seconds];
        [self.view.codeBtn setEnabled:NO];
        [self.view.codeBtn setTitle:title forState:UIControlStateNormal];
    }
}

/**
 *  注册事件
 */
- (void)registerHandle
{
    //再次获取手机号码以验证没有对号码进行修改
    NSString *phoneChange = [[NSString alloc]init];
    phoneChange=self.view.phoneText.text;
    
    //验证号码一致
    if (![_phone isEqualToString:phoneChange]) {
        self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"手机号码不正确，请重新注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [self.MainService.promptAlert show];
        return;
    }
    
    //验证验证码是否正确
    if (![_requestCode isEqualToString:self.view.codeText.text]) {
        self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"验证码不正确，请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [self.MainService.promptAlert show];
        return;
    }
    
    [self.view.registerBtn setEnabled:NO];
    //请求条件
    NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:_phone ,@"phone",self.view.passwordText.text,@"password",self.view.passwordAgainText.text,@"passwordAgain",nil];
    
    DSJSONRPCCompletionHandler requestPhoneCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        NSLog(@"%@",methodResult);
        NSString *code = [methodResult objectForKey:@"code"];
        
        if ([code isEqualToString:@"020201"]) {
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"手机号码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.registerBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"020202"]) {
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"手机号码已注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.registerBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"020203"]) {
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"密码格式不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.registerBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"020204"]) {
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"两次密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.registerBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"020205"]) {
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"注册失败，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.registerBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"020200"]) {
           //成功注册后直接执行登陆操作
            NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:_phone,@"username",self.view.passwordText.text,@"password",nil];
            
            
            DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
                
                NSString *code = [methodResult objectForKey:@"code"];
                if ([code isEqualToString:@"010101"]){
                    self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"请输入正确格式的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [self.MainService.promptAlert show];
                    return;
                }
                if ([code isEqualToString:@"010102"]){
                    self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"密码格式不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [self.MainService.promptAlert show];
                    return;
                }
                if ([code isEqualToString:@"010103"]){
                    self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"用户不存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [self.MainService.promptAlert show];
                    return;
                }
                if ([code isEqualToString:@"010104"]){
                    self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [self.MainService.promptAlert show];
                    return;
                }
                if ([code isEqualToString:@"010105"]){
                    self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"创建证书失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [self.MainService.promptAlert show];
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
                
                [self.view.registerBtn setEnabled:YES];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            };
            
            
            [self RPCUseClass:@"Sessions" callMethodName:@"create" withParameters:parameters onCompletion:completionHandler];
            
            
            return;
        }
        
    };
    
    //注册请求
    [self RPCUseClass:@"Tenants" callMethodName:@"create" withParameters:condition onCompletion:requestPhoneCompletionHandler];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 点击别的地方使输入框隐藏
-(void)viewTapped
{
    [self.view endEditing:YES];
}

@end
