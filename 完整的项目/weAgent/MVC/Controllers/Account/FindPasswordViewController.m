//
//  FindPasswordViewController.m
//  weChat
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "FindPasswordViewController.h"
#import "RootViewController.h"

@interface FindPasswordViewController ()

@end

@implementation FindPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //设定倒计时时间
    _seconds=60;
   
    self.view = [[FindPassword alloc] init];
    //注册按钮点击事件
    [self.view.codeBtn addTarget:self action:@selector(codeHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.findBtn addTarget:self action:@selector(findHandle) forControlEvents:UIControlEventTouchUpInside];
    
    //点击空白区域，键盘隐藏
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    //不发送取消事件消息
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)codeHandle
{
    //初始化并获取手机号码
    _phone = [[NSString alloc]init];
    _phone=self.view.phoneText.text;
    
    //获取验证码请求条件
    NSDictionary *requestPhone = [NSDictionary dictionaryWithObjectsAndKeys:_phone ,@"requestPhone",@"findPassword",@"type",nil];
    
    
    DSJSONRPCCompletionHandler requestPhoneCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
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
        if ([code isEqualToString:@"020100"]) {
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"验证码发送成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            _requestCode =[methodResult objectForKey:@"result"];
            
            //调用按钮倒计时方法
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
            
            return;
        }
        
    };
    
    
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
 *  找回密码
 */
- (void)findHandle
{
    //再次获取电话
    NSString *phoneChange = [[NSString alloc]init];
    phoneChange=self.view.phoneText.text;
    
    if (![_phone isEqualToString:phoneChange]) {
        self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"手机号码不正确，请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [self.MainService.promptAlert show];
        return;
    }
    
    if (![_requestCode isEqualToString:self.view.codeText.text]) {
        self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"验证码不正确，请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [self.MainService.promptAlert show];
        return;
    }
    
    [self.view.findBtn setEnabled:NO];
    NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:_phone ,@"phone",self.view.passwordText.text,@"password",self.view.passwordAgainText.text,@"passwordAgain",nil];
    
    DSJSONRPCCompletionHandler requestPhoneCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        //验证码
        NSString *code = [methodResult objectForKey:@"code"];
        
        if ([code isEqualToString:@"020201"]) {
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"手机号码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.findBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"020202"]) {
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"手机号码未注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.findBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"020203"]) {
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"密码格式不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.findBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"020204"]) {
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"两次密码不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.findBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"020205"]) {
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"找回密码失败，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [self.MainService.promptAlert show];
            [self.view.findBtn setEnabled:YES];
            return;
        }
        if ([code isEqualToString:@"020300"]) {
            
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
                
                NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]);
                [[NSUserDefaults standardUserDefaults] setObject:[[methodResult objectForKey:@"result"] objectForKey:@"username"] forKey:@"phone"];
                [[NSUserDefaults standardUserDefaults] setObject:[[methodResult objectForKey:@"result"] objectForKey:@"name"] forKey:@"name"];
                [self.view.findBtn setEnabled:YES];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            };
            
            
            [self RPCUseClass:@"Sessions" callMethodName:@"create" withParameters:parameters onCompletion:completionHandler];
            return;
        }
        
    };
    
    
    [self RPCUseClass:@"Tenants" callMethodName:@"resetPassword" withParameters:condition onCompletion:requestPhoneCompletionHandler];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark 点击别的地方使输入框隐藏
-(void)viewTapped
{
    [self.view endEditing:YES];
}
@end
