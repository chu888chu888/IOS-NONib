//
//  RentInfoModel.m
//  weAgent
//
//  Created by apple on 14-10-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "RentInfoModel.h"

@implementation RentInfoModel

//可以定义keyMapper，将json对象的键值转换为自己想要的名称
//+(JSONKeyMapper*)keyMapper
//{
//    return [[JSONKeyMapper alloc] initWithDictionary:@{
//                                                       @"order_id": @"id",
//                                                       @"order_details.name": @"productName",
//                                                       @"order_details.price.usd": @"price"
//                                                       }];
//}
//当然，如果需要，可以设置全局得keyMaper对照表
//+(void)setGlobalKeyMapper:(JSONKeyMapper*)globalKeyMapper;

//内置http客户端，用法：
//add extra headers
//[[JSONHTTPClient requestHeaders] setValue:@"MySecret" forKey:@"AuthorizationToken"];
//make post, get requests
//[JSONHTTPClient postJSONFromURLWithString:@"http://mydomain.com/api"
//                                   params:@{@"postParam1":@"value1"}
//                               completion:^(id json, JSONModelError *err) {
//                                   
//                                   //check err, process json ...
//                                   
//                               }];

//除以上功能外，还提供：错误处理，常规得data转换，以及对象比较等功能
//应该可以达到我们模型的需求了

@end
