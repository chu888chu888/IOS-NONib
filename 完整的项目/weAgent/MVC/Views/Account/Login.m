//
//  Login.m
//  weChat
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "Login.h"

@implementation Login

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) initialize
{
//    [self.linearLayoutView setBackgroundColor:[UIColor whiteColor]];
    [self addView];
    [self addLinkView];
    _nameText.delegate = self;
    _passwordText.delegate = self;

}

-(void) addView
{
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    [logoView setImage:[UIImage imageNamed:@"logo"]];
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:logoView];
    item.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:item];
    
    
    _nameText = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 44)];
    _nameText.borderStyle = UITextBorderStyleNone;
    _nameText.placeholder = @"请输入电话号码";
    _nameText.returnKeyType = UIReturnKeyDone;
    [_nameText beGreen];
    [_nameText addUserLeftImg];
  
    CSLinearLayoutItem *nameTextItem = [CSLinearLayoutItem layoutItemForView:_nameText];
    nameTextItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    nameTextItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:nameTextItem];
    
    _passwordText = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 44)];
    _passwordText.borderStyle = UITextBorderStyleNone;
    _passwordText.placeholder = @"请输入密码";
    _passwordText.secureTextEntry=YES;
    _passwordText.returnKeyType = UIReturnKeyDone;
    [_passwordText beGreen];
    [_passwordText addLockLeftImg];
    CSLinearLayoutItem *passwordTextItem = [CSLinearLayoutItem layoutItemForView:_passwordText];
    passwordTextItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    passwordTextItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:passwordTextItem];

    
    _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 44)];
    [_loginBtn beBlue];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    CSLinearLayoutItem *loginBtnItem = [CSLinearLayoutItem layoutItemForView:_loginBtn];
    loginBtnItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    loginBtnItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:loginBtnItem];
  
}

-(void) addLinkView{
    
    _registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 70, 35)];
    [_registerBtn beBlueLink];
    [_registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    
    _findBtn = [[UIButton alloc] initWithFrame:CGRectMake(220.0, 0.0, 70, 35)];
    [_findBtn beBlueLink];
    [_findBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    
    UIView *btnItemsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 35)];
    [btnItemsView addSubview:_registerBtn];
    [btnItemsView addSubview:_findBtn];
 
    CSLinearLayoutItem *btnItems = [CSLinearLayoutItem layoutItemForView:btnItemsView];
    btnItems.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    btnItems.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:btnItems];
   
    
}


//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
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
