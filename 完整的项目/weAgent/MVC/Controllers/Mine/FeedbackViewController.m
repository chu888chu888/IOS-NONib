//
//  FeedbackViewController.m
//  weAgent
//
//  Created by 王拓 on 14/12/11.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[Feedback alloc]init];
    self.title = @"反馈";
    
    [self.view.commitBtn addTarget:self action:@selector(commitFeedBack) forControlEvents:UIControlEventTouchUpInside];
    
    //点击空白区域，键盘隐藏
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    //不发送取消事件消息
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  提交反馈内容
 */
-(void)commitFeedBack{

    NSString *feedbackText = self.view.feedbackText.text;
    
    //如果为空则提示
    if (feedbackText == nil || feedbackText == NULL || feedbackText.length == 0) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请填写内容，谢谢！" delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
        
        [alter show];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alter dismissWithClickedButtonIndex:0 animated:YES];
        });
        
        return;

    }
    
    //生成参数
    NSDictionary *NSDparameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",feedbackText,@"content",nil];
    
    
    DSJSONRPCCompletionHandler feedbackCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            if ([[methodResult objectForKey:@"message"] isEqualToString:@"Success"] ) {
                
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功，感谢您的反馈！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alter show];
            }else{
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交失败，请重试！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alter show];
            }
            
        };
        
        
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
    
        
        
    };
    
    //发送请求
    [self RPCUseClass:@"Feedbacks" callMethodName:@"index" withParameters:NSDparameters onCompletion:feedbackCompletionHandler];
    
    
}

/**
 *  提示框点击后事件
 *
 *  @param alertView
 *  @param buttonIndex
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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
