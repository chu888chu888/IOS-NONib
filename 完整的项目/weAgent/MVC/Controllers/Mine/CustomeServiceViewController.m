//
//  CustomeServiceViewController.m
//  weChat
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "CustomeServiceViewController.h"


@interface CustomeServiceViewController ()

@end

@implementation CustomeServiceViewController


-(void)loadView{
    self.view = [[CustomeService alloc] init];


    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"客服中心"];
    
    [self.view.ServiceOne addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.ServiceTwo addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  按钮点击触发事件
 *
 *  @param sender
 */
-(void)clickBtn:(id)sender{

    UIButton *btn = (UIButton *)sender;

    switch (btn.tag) {
        case 1:
            [self callPhone:@"18012685169"];
            break;
        case 2:
            [self callPhone:@"15262699832"];
            
        default:
            break;
    }

}

/**
 *  拨打电话，模拟器无法测试（待测试）
 *
 *  @param phoneNumber 电话号码
 */
-(void)callPhone:(NSString *)phoneNumber{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}
@end
