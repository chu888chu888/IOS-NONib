//
//  Register.m
//  weChat
//
//  Created by apple on 14-9-22.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "Register.h"

@implementation Register

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize
{
//     self.linearLayoutView.scrollEnabled == NO;
    [self addInput];
//    [self.linearLayoutView setBackgroundColor:[UIColor whiteColor]];
    _phoneText.delegate = self;
    _passwordText.delegate = self;
    _passwordAgainText.delegate = self;
    _codeText.delegate = self;
   
    
}


//创建输入框
- (void)addInput
{
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    [logoView setImage:[UIImage imageNamed:@"logo"]];
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:logoView];
    item.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:item];
    
    
    _phoneText = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 44)];
    _phoneText.borderStyle = UITextBorderStyleNone;
    _phoneText.placeholder = @"电话号码";
    [_phoneText beGreen];
    CSLinearLayoutItem *phoneTextitem = [CSLinearLayoutItem layoutItemForView:_phoneText];
    phoneTextitem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    phoneTextitem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:phoneTextitem];
    
    _codeText = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 44)];
    _codeText.borderStyle = UITextBorderStyleNone;
    _codeText.placeholder = @"验证码";
    _codeText.tag=1;
    [_codeText beGreen];
    _codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(190.0, 0.0, 100, 44)];
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_codeBtn beBlue];
    _codeBtn.titleLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
    _codeView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 44)];
    [_codeView addSubview:_codeText];
    [_codeView addSubview:_codeBtn];
    CSLinearLayoutItem *codeItem = [CSLinearLayoutItem layoutItemForView:_codeView];
    codeItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    codeItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:codeItem];
    
   
    
    _passwordText = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 44)];
    _passwordText.borderStyle = UITextBorderStyleRoundedRect;
    _passwordText.placeholder = @"密码";
    _passwordText.secureTextEntry=YES;
   [_passwordText beGreen];
    CSLinearLayoutItem *passwordTextItem = [CSLinearLayoutItem layoutItemForView:_passwordText];
    passwordTextItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    passwordTextItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:passwordTextItem];
    
    _passwordAgainText = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 44)];
    _passwordAgainText.borderStyle = UITextBorderStyleRoundedRect;
    _passwordAgainText.placeholder = @"再次输入密码";
    _passwordAgainText.secureTextEntry=YES;
    [_passwordAgainText beGreen];
    CSLinearLayoutItem *passwordAgainTextItem = [CSLinearLayoutItem layoutItemForView:_passwordAgainText];
    passwordAgainTextItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    passwordAgainTextItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:passwordAgainTextItem];
    
    
    
    _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 44)];
    [_registerBtn beOrange];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    CSLinearLayoutItem *registerBtnItem = [CSLinearLayoutItem layoutItemForView:_registerBtn];
    registerBtnItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    registerBtnItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:registerBtnItem];
    
    }

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame;
    if (textField.tag == 1) {
        frame = _codeView.frame;
    }else{
        frame = textField.frame;
    }
    
    int offset = frame.origin.y + 32 - (self.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.frame = CGRectMake(0.0f, -offset, self.frame.size.width, self.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.frame =CGRectMake(0, 64, self.frame.size.width, self.frame.size.height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
