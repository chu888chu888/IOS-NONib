//
//  ChangePassword.m
//  weAgent
//
//  Created by 王拓 on 14/12/16.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "ChangePassword.h"

@implementation ChangePassword

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize {

    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    [logoView setImage:[UIImage imageNamed:@"logo"]];
    CSLinearLayoutItem *item = [CSLinearLayoutItem layoutItemForView:logoView];
    item.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    item.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:item];
    
    _passwordOldText = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 44)];
    _passwordOldText.borderStyle = UITextBorderStyleRoundedRect;
    _passwordOldText.placeholder = @"旧密码";
    _passwordOldText.secureTextEntry=YES;
    [_passwordOldText beGreen];
    CSLinearLayoutItem *passwordOldTextItem = [CSLinearLayoutItem layoutItemForView:_passwordOldText];
    passwordOldTextItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    passwordOldTextItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:passwordOldTextItem];
    
    _passwordText = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 44)];
    _passwordText.borderStyle = UITextBorderStyleRoundedRect;
    _passwordText.placeholder = @"新密码";
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
    
    
    
    _findBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 44)];
    [_findBtn beOrange];
    [_findBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    CSLinearLayoutItem *findBtnItem = [CSLinearLayoutItem layoutItemForView:_findBtn];
    findBtnItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    findBtnItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:findBtnItem];
    
    _passwordOldText.delegate=self;
    _passwordAgainText.delegate=self;
    _passwordText.delegate=self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
@end
