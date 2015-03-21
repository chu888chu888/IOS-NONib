//
//  MainFunction.h
//  weAgent
//
//  Created by apple on 14/11/14.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

//程序的自定义单例，用来存放全局变量和方法，给程序提供服务，节省内存。marenqing
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "CacheEntities.h"

//定义rpc主要处理块
//这里有时间我要全部重构
typedef void (^RPCMainHandler)(id methodResult);


@interface MainService : NSObject<DSJSONRPCDelegate>

+ (MainService *) sharedInstance;

@property(nonatomic,retain) AppDelegate* myAppDelegate;
#pragma mark 一般缓存
//过期时间
@property (nonatomic) int overdueTime;
//缓存接口
@property (nonatomic,strong) NSArray* RequestesNeedCache;
//永久缓存接口
@property (nonatomic,strong) NSArray* needCacheForever;

//判断是否需要加载远程数据
- (BOOL) ifNeedRemoteData:(NSMutableArray *)mutableFetchResult withClass:(NSString*)className;

//获取缓存数据
- (NSMutableArray*) getCacheData:(NSString *)requestIdentification withParameters:(NSString*)methodParams;

//判断缓存是否过期
- (BOOL) ifCacheoverdue:(NSMutableArray*)mutableFetchResult;

//获取识别码
+ (NSString*) getCacheIdentification:(NSString*)requestIdentification withParameters:(NSString*)methodParams;

+ (NSString*) getRequestIdentification:className withMethod:methodName;
- (BOOL)ifRequestNeedCache:(NSString*)className;

//保存cache
- (void)saveCache:(id)methodResult withRequestIdentification:(NSString*)requestIdentification andParameters:(NSString*)parameters;

//用缓存得数据库结构，来保存持久化数据
- (void)saveData:(id)methodResult withRequestIdentification:(NSString*)requestIdentification andParameters:(NSString*)parameters;

//删除缓存
- (void)deleteCacheWithRequestIdentification:(NSString*)requestIdentification;


#pragma mark RPC操作
//RPC操作


//移除弹出框
//- (void)removeInfo;

#pragma mark 累计缓存
@property (nonatomic) int accumulateOverdueTime;
//+ (NSString*)getAccumulateIdentification:(NSString *)cacheIdentification withAccumulateType:(NSString *)accumulateType;
- (int)accumulateOnce:(NSString *)accumulateIdentification;
- (int)getAccumulateNum:(NSString *)accumulateIdentification;
+ (NSString *) getAIDEWithTableId:(NSString *)tableId rowId:(NSString *)rowId field:(NSString *)field;

#pragma mark 其他服务
//弹出框
@property (nonatomic) UIAlertView *promptAlert;
//是否有网
+ (BOOL) isNetworkEnabled;
//获得房源图片
+ (UIImage*) getHouseImage:(NSString*)houseType;
//json转换
+ (NSString *)formatToJsonString:(NSDictionary *)certificate;
+ (NSDictionary *)JsonStringToDictionary:(NSString *)jsonString;
//将日期转化为今天等
+ (NSString *)becomeDiffTime:(NSString *)inputTime;
+ (NSString *)becomeCallDiffTime:(NSString *)inputTime;
//获取雷达中心点
+ (NSDictionary *)getHome;
@end
