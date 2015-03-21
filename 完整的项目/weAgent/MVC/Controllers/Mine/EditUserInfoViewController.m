//
//  EditUserInfoViewController.m
//  weAgent
//
//  Created by 王拓 on 14/12/17.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "EditUserInfoViewController.h"

@interface EditUserInfoViewController ()

@end

@implementation EditUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"修改名称"];
    self.view = [[EditUserInfo alloc]init];
    self.view.nameText.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    [self.view.commitBtn addTarget:self action:@selector(editName) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)editName{

    NSString *newName = self.view.nameText.text;
    NSDictionary *NSDparameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",newName,@"name",nil];
    
    
    DSJSONRPCCompletionHandler editCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            
            NSString *code = [methodResult objectForKey:@"code"];
            
            if ([code isEqualToString:@"120301"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"名称格式不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                return;
            }
            
            if ([code isEqualToString:@"120302"]) {
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"保存失败请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [self.MainService.promptAlert show];
                return;
            }
            
            if ([code isEqualToString:@"120300"]) {
                [[NSUserDefaults standardUserDefaults] setObject:newName forKey:@"name"];
                [self.navigationController popViewControllerAnimated:YES];
                
                return;
            }
            
            
        };
        
        
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];

        
        
    };

    [self RPCUseClass:@"Users" callMethodName:@"edit" withParameters:NSDparameters onCompletion:editCompletionHandler];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
