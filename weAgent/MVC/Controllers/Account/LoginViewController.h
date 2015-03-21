//
//  LoginViewController.h
//  weChat
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "AccountViewController.h"
#import "login.h"

@interface LoginViewController : AccountViewController<UITextFieldDelegate>
@property (nonatomic) Login *view;
@end
