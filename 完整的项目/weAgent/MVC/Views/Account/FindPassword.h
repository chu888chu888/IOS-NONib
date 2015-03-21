//
//  FindPassword.h
//  weAgent
//
//  Created by 王拓 on 14/12/8.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalUIView.h"

@interface FindPassword : GlobalUIView<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *phoneText;
@property (strong, nonatomic) UITextField *codeText;
@property (strong, nonatomic) UITextField *passwordText;
@property (strong, nonatomic) UITextField *passwordAgainText;
@property (strong, nonatomic) UIButton *codeBtn;
@property (strong, nonatomic) UIButton *findBtn;
@property(strong, nonatomic) UIView *codeView;
@end
