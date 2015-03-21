//
//  GlobalViewController.h
//  weChat
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "UIViewController+functions.h"
#import "GlobalNavigationViewController.h"
#import "MainService.h"
#import "AppDelegate.h"

@interface GlobalViewController : UIViewController


//实现单例模式，来定义全局变量和函数
@property (nonatomic) MainService *MainService;
@property (nonatomic,strong) NSString *requestIdentification;
@property(nonatomic,retain)AppDelegate* myAppDelegate;
- (void)RPCUseClass:(NSString *)ClassName callMethodName:(NSString *)methodName withParameters:(NSDictionary *)NSDparameters onCompletion:(DSJSONRPCCompletionHandler)completionHandler;
//验证code是否正确
- (void)validateCode:(id)methodResult withRequestIdentification:(NSString*)identification andParameters:(NSDictionary*)NSDparameters onCompletion:(RPCMainHandler)RPCMainHandler;
@end
