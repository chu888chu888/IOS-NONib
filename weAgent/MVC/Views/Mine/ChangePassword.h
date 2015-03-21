//
//  ChangePassword.h
//  weAgent
//
//  Created by 王拓 on 14/12/16.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalUIView.h"

@interface ChangePassword : GlobalUIView<UITextFieldDelegate>

@property (nonatomic)UITextField *passwordOldText;
@property (nonatomic)UITextField *passwordText;
@property (nonatomic)UITextField *passwordAgainText;
@property (nonatomic)UIButton *findBtn;

@end
