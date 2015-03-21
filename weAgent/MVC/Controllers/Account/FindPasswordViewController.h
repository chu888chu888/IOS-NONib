//
//  FindPasswordViewController.h
//  weChat
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "GlobalViewController.h"
#import "FindPassword.h"

@interface FindPasswordViewController : GlobalViewController

@property (nonatomic) FindPassword *view;
@property (nonatomic) NSString *requestCode;
@property (nonatomic) NSString *phone;
@property (nonatomic) int seconds;

@end
