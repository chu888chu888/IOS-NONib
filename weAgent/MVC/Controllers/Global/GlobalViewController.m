//
//  GlobalViewController.m
//  weChat
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "GlobalViewController.h"
#import "CacheEntities.h"

@interface GlobalViewController ()

@end

@implementation GlobalViewController

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    _MainService = [MainService sharedInstance];
    _myAppDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

//友盟的页面跟踪
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

#pragma mark rpc
//rpc请求封装
- (void)RPCUseClass:(NSString *)ClassName callMethodName:(NSString *)methodName withParameters:(NSDictionary *)NSDparameters onCompletion:(DSJSONRPCCompletionHandler)completionHandler {
    
    NSURL *NSURLString = [NSURL URLWithString:[@"http://121.42.43.165/Home/" stringByAppendingString:ClassName]];
    NSString *parameters = [MainService formatToJsonString:NSDparameters];
    
    //这里有点问题，会造成数据库中有多余数据，不过问题不大 marenqing
    self.requestIdentification = [MainService getRequestIdentification:ClassName withMethod:methodName];
    DSJSONRPC *jsonRPC = [[DSJSONRPC alloc] initWithServiceEndpoint:NSURLString];
    
    if (![self.MainService ifRequestNeedCache:self.requestIdentification]) {
        [jsonRPC callMethod:methodName withParameters:parameters onCompletion:completionHandler];
        return;
    }
    
    
    NSMutableArray * cacheData = [self.MainService getCacheData:self.requestIdentification withParameters:parameters];
    
    
    if ([self.MainService ifNeedRemoteData:cacheData withClass:ClassName]) {
        [jsonRPC callMethod:methodName withParameters:parameters onCompletion:completionHandler];
    }else{
        if ((cacheData == nil)||([cacheData count] == 0)) {
            completionHandler(methodName, 0, nil, nil, nil);
        }else{
            CacheEntities *cache= (CacheEntities*)cacheData[0];
            //string转Dictionary
            NSDictionary *resultsDictionary = [MainService JsonStringToDictionary:cache.data_cache];
            completionHandler(methodName, 0, resultsDictionary, nil, nil);
        }
        
    }
}

//验证rpc返回
- (void)validateCode:(id)methodResult withRequestIdentification:(NSString*)identification andParameters:(NSDictionary*)NSDparameters onCompletion:(RPCMainHandler)RPCMainHandler {
    if (methodResult !=nil) {
        NSString *code = [methodResult objectForKey:@"code"];
        NSString *parameters = [MainService formatToJsonString:NSDparameters];
        if ([code isEqualToString:@"000101"]||[code isEqualToString:@"000102"]||[code isEqualToString:@"000103"]) {
            [self loginHandle];
        }else{
            
            RPCMainHandler(methodResult);
            DS_RELEASE(RPCMainHandler);
            [self.MainService saveCache:methodResult withRequestIdentification:identification andParameters:parameters];
        }
    }
}


@end
