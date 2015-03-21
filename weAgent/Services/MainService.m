//
//  MainFunction.m
//  weAgent
//
//  Created by apple on 14/11/14.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "MainService.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "DSJSONRPC.h"
#import "JSONKit.h"
#import "LoginViewController.h"
#import "GlobalNavigationViewController.h"
#import "NumCacheEntitie.h"

@implementation MainService

static MainService * sharedMainService = nil;

#pragma mark 初始化
-(id)init
{
    if (self=[super init]) {
        _myAppDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        //注册要缓存的接口
        _RequestesNeedCache = @[
                                @"Call,getCallRecordsPage",
                                @"Wanted,getSingleInfo",
                                @"RentResources,getSingleInfo",
                                @"SecondHouses,getSingleInfo",
                                @"ItvArticles,index",
                                @"ItvArticles,show",
                                @"Follow,getWantedFollowPage",
                                @"Follow,getRentResourcesFollowPage",
                                @"Follow,getSecondFollowPage",
                                @"Call,getAchievements"
                                ];
        //永久缓存
        _needCacheForever = @[
                              
                              ];
        
        _overdueTime = 60*60;
        //一个小时内查看一次有效，如果一个小时内查看了多次，却没有在一个小时候再次查看，则为无效查看
        _accumulateOverdueTime = 60*60;
    }
    return self;
}

#pragma mark 判断是否有网

+(BOOL) isNetworkEnabled
{
    BOOL bEnabled = FALSE;
    NSString *url = @"www.baidu.com";
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    if (bEnabled) {
        //        kSCNetworkReachabilityFlagsReachable：能够连接网络
        //        kSCNetworkReachabilityFlagsConnectionRequired：能够连接网络，但是首先得建立连接过程
        //        kSCNetworkReachabilityFlagsIsWWAN：判断是否通过蜂窝网覆盖的连接，比如EDGE，GPRS或者目前的3G.主要是区别通过WiFi的连接。
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
    }
    
    return bEnabled;
}

#pragma mark 缓存实现
- (NSMutableArray*) getCacheData:requestIdentification withParameters:(NSString*)methodParams{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSString *identification = [MainService getCacheIdentification:requestIdentification withParameters:methodParams];
    
    NSEntityDescription* cacheEntity=[NSEntityDescription entityForName:@"CacheEntities" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
    [request setEntity:cacheEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identification=%@",identification];
    [request setPredicate:predicate];
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[self.myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    return mutableFetchResult;
}


- (BOOL) ifNeedRemoteData:(NSMutableArray *)mutableFetchResult withClass:(NSString*)className
{
    //没缓存，网上取
    if (([mutableFetchResult count] == 0)||(mutableFetchResult == nil)){
        return YES;
    }
    //没网，本地取
    if (![MainService isNetworkEnabled]) {
        return NO;
    }
    //过期，网上取
    NSDate *datenow = [NSDate date];
    NSTimeInterval now=[datenow timeIntervalSince1970]*1;
    CacheEntities *cache= (CacheEntities*)mutableFetchResult[0];
    NSTimeInterval update = [cache.update_at timeIntervalSince1970]*1;
    if ((now-update)>self.overdueTime) {
        return YES;
    }
    
    return NO;
}

- (BOOL) ifCacheoverdue:(NSMutableArray*)mutableFetchResult{
    NSDate *datenow = [NSDate date];
    NSTimeInterval now=[datenow timeIntervalSince1970]*1;
    CacheEntities *cache= (CacheEntities*)mutableFetchResult[0];
    NSTimeInterval update = [cache.update_at timeIntervalSince1970]*1;
    if ((now-update)>self.overdueTime) {
        return YES;
    }
    return NO;
}

//保存持久化数据
- (void)saveData:(id)methodResult withRequestIdentification:(NSString*)requestIdentification andParameters:(NSString*)parameters{
    NSMutableArray* mutableFetchResult= [self getCacheData:requestIdentification withParameters:parameters];
    NSError* error;
    NSString *identification = [MainService getCacheIdentification:requestIdentification withParameters:parameters];
    if (([mutableFetchResult count] == 0)||(mutableFetchResult == nil)) {
        //            数据得插入
        CacheEntities* cacheData = (CacheEntities*)[NSEntityDescription insertNewObjectForEntityForName:@"CacheEntities" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
        [cacheData setCreate_at:[NSDate date]];
        [cacheData setIs_vaild:[NSNumber numberWithBool:true]];
        [cacheData setUpdate_at:[NSDate date]];
        [cacheData setIdentification:identification];
        [cacheData setData_cache:[MainService formatToJsonString:methodResult]];
        [self.myAppDelegate.managedObjectContext save:&error];
        
    }else{
        //要进行保存，否则没更新
        CacheEntities* cache = (CacheEntities*)mutableFetchResult[0];
        NSString *resultString = [MainService formatToJsonString:methodResult];
        [cache setUpdate_at:[NSDate date]];
        [cache setData_cache:resultString];
        [self.myAppDelegate.managedObjectContext save:&error];
    }
}




//保存cache
- (void)saveCache:(id)methodResult withRequestIdentification:(NSString*)requestIdentification andParameters:(NSString*)parameters{
    if ([self ifRequestNeedCache:requestIdentification]) {
        
        NSMutableArray* mutableFetchResult= [self getCacheData:requestIdentification withParameters:parameters];
        NSError* error;
        NSString *identification = [MainService getCacheIdentification:requestIdentification withParameters:parameters];
        if (([mutableFetchResult count] == 0)||(mutableFetchResult == nil)) {
            //            数据得插入
            CacheEntities* cacheData = (CacheEntities*)[NSEntityDescription insertNewObjectForEntityForName:@"CacheEntities" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
            [cacheData setCreate_at:[NSDate date]];
            [cacheData setIs_vaild:[NSNumber numberWithBool:true]];
            [cacheData setUpdate_at:[NSDate date]];
            [cacheData setIdentification:identification];
            [cacheData setData_cache:[MainService formatToJsonString:methodResult]];
            
            [self.myAppDelegate.managedObjectContext save:&error];
            
        }else{
            if([self ifCacheoverdue:mutableFetchResult]){
                //要进行保存，否则没更新
                CacheEntities* cache = (CacheEntities*)mutableFetchResult[0];
                NSString *resultString = [MainService formatToJsonString:methodResult];
                [cache setUpdate_at:[NSDate date]];
                [cache setData_cache:resultString];
                [self.myAppDelegate.managedObjectContext save:&error];
                
                
                //如果是详情页，那就清空点击数，拉黑等累计
                NSDictionary *tableIdDict = @{
                                              @"Wanted": @"1",
                                              @"RentResources": @"2",
                                              @"SecondHouses": @"3",
                                              };
                
                NSArray *parametersArray = [requestIdentification componentsSeparatedByString:@","];
          
                if ([requestIdentification rangeOfString:@",getSingleInfo"].location != NSNotFound ) {
                    
                    NSDictionary *paraDict = [MainService JsonStringToDictionary:parameters];
                    NSFetchRequest *request = [[NSFetchRequest alloc] init];
                    NSEntityDescription* cacheEntity=[NSEntityDescription entityForName:@"NumCacheEntitie" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
                    [request setEntity:cacheEntity];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identification  LIKE %@",[NSString stringWithFormat:@"%@,%@,d_*",[tableIdDict objectForKey:parametersArray[0]],[paraDict objectForKey:@"id"]]];
                    [request setPredicate:predicate];
                    NSError* error=nil;
                    NSMutableArray* mutableFetchResultTwo=[[self.myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
                    if(!error){
                        for(CacheEntities*object in mutableFetchResultTwo) {
                            [self.myAppDelegate.managedObjectContext deleteObject:object];
                        }
                    }
                    if([self.myAppDelegate.managedObjectContext hasChanges]) {
                        [self.myAppDelegate.managedObjectContext save:&error];
                    }
                    
                }
                
                
            }
        }
        
    }
}

//删除缓存
- (void)deleteCacheWithRequestIdentification:(NSString*)requestIdentification{
    
    NSEntityDescription* cacheEntity=[NSEntityDescription entityForName:@"CacheEntities" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:cacheEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identification  LIKE %@",[requestIdentification stringByAppendingString:@"*"]];
    [request setPredicate:predicate];
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[self.myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if(!error){
        for(CacheEntities*object in mutableFetchResult) {
            [self.myAppDelegate.managedObjectContext deleteObject:object];
        }
    }
    
    if([self.myAppDelegate.managedObjectContext hasChanges]) {
        [self.myAppDelegate.managedObjectContext save:&error];
    }
}


//这个类是否需要缓存
- (BOOL)ifRequestNeedCache:(NSString*)RequestIdentification{
    return [self.RequestesNeedCache containsObject:RequestIdentification];
}

#pragma mark 各种标识
//获取cache标示
+ (NSString*) getCacheIdentification:(NSString*)requestIdentification withParameters:(NSString*)methodParams
{
    return [[requestIdentification stringByAppendingString:@","] stringByAppendingString:methodParams];
}

//获取请求标示
+ (NSString*) getRequestIdentification:className withMethod:methodName{
    return [[className stringByAppendingString:@","] stringByAppendingString:methodName];
}



#pragma mark 单例实现
//提供1个类方法让外界访问唯一的实例
+ (MainService*)sharedInstance
{
    //    @synchronized 的作用是创建一个互斥锁，保证此时没有其它线程对self对象进行修改。这个是objective-c的一个锁定令牌，防止self对象在同一时间内被其它线程访问，起到线程的保护作用。
    @synchronized(self) {
        if (!sharedMainService) {
            sharedMainService = [[self alloc] init];
        }
    }
    return sharedMainService;
}


//重写allocWithZone:方法，在这里创建唯一的实例（注意线程安全）
+ (id)allocWithZone:(struct _NSZone *)zone
{    @synchronized(self) {
    if (!sharedMainService) {
        sharedMainService = [super allocWithZone:zone];
    }
}
    return sharedMainService;
}

//实现copyWithZone:方法
+ (id)copyWithZone:(struct _NSZone *)zone
{
    return sharedMainService;
}


#pragma mark 累计缓存服务（包括计算可用度）

+ (NSString *) getAIDEWithTableId:(NSString *)tableId rowId:(NSString *)rowId field:(NSString *)field
{
    return [NSString stringWithFormat:@"%@,%@,%@",tableId,rowId,field];
}

//得到累计记录的标识
//+ (NSString*)getAccumulateIdentification:(NSString *)cacheIdentification withAccumulateType:(NSString *)accumulateType{
//    return [[cacheIdentification stringByAppendingString:@","] stringByAppendingString:accumulateType];
//
//}

//累计一次,返回点击次数
- (int)accumulateOnce:(NSString *)accumulateIdentification {
    
    int accumulateNum;
    NSArray *parametersArray = [accumulateIdentification componentsSeparatedByString:@","];
    //获得数据
    NSMutableArray* mutableFetchResult= [self getAccumulateRecord:accumulateIdentification];
    NSError* error;
    
    if (([mutableFetchResult count] == 0)||(mutableFetchResult == nil)) {
        //            数据得插入
        [self addAnAccumulateRecord:accumulateIdentification];
        accumulateNum = 1;
    }else{
        NumCacheEntitie* cache = (NumCacheEntitie*)mutableFetchResult[0];
        accumulateNum = [cache.accumulate_num intValue]+1;
        //判断是否缓存过期了
        if ([parametersArray[2] isEqualToString:@"click_num"]&&[self ifAccumulateOverdue:mutableFetchResult]) {
            //如果过期，并且过期的是点击数，则进行上传点击数
            [self pushAccumulateRecord:accumulateIdentification withNum:accumulateNum-1];
        }else{
            //否则，只进行简单地保存
            [cache setAccumulate_num:[NSNumber numberWithInt:accumulateNum]];
            [cache setUpdate_at:[NSDate date]];
            [self.myAppDelegate.managedObjectContext save:&error];
        }
    }
    return accumulateNum;
}


//获得累计次数
- (int)getAccumulateNum:(NSString *)accumulateIdentification {
    
    int accumulateNum;
    //获得数据
    NSMutableArray* mutableFetchResult= [self getAccumulateRecord:accumulateIdentification];
    
    if (([mutableFetchResult count] == 0)||(mutableFetchResult == nil)) {
        accumulateNum = 0;
    }else{
        NumCacheEntitie* cache = (NumCacheEntitie*)mutableFetchResult[0];
        accumulateNum = [cache.accumulate_num intValue];
    }
    return accumulateNum;
}


//增加记录
- (void)addAnAccumulateRecord:(NSString *)accumulateIdentification{
    NSError* error;
    NumCacheEntitie* cacheData = (NumCacheEntitie*)[NSEntityDescription insertNewObjectForEntityForName:@"NumCacheEntitie" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
    [cacheData setCreate_at:[NSDate date]];
    [cacheData setIs_vaild:[NSNumber numberWithBool:true]];
    [cacheData setUpdate_at:[NSDate date]];
    [cacheData setIdentification:accumulateIdentification];
    [cacheData setAccumulate_num:[NSNumber numberWithInt:1]];
    
    [self.myAppDelegate.managedObjectContext save:&error];
}

//是否累计缓存过期
- (BOOL) ifAccumulateOverdue:(NSMutableArray*)mutableFetchResult{
    NSDate *datenow = [NSDate date];
    NSTimeInterval now=[datenow timeIntervalSince1970]*1;
    NumCacheEntitie *cache= (NumCacheEntitie*)mutableFetchResult[0];
    NSTimeInterval update = [cache.update_at timeIntervalSince1970]*1;
    if ((now-update)>self.accumulateOverdueTime) {
        return YES;
    }
    return NO;
}





//提交服务器数据，清空缓存
- (void)pushAccumulateRecord:(NSString *)accumulateIdentification withNum:(int)num{
    
    NSDictionary *tableIdDict = @{
                                  @"1": @"Wanted",
                                  @"2": @"RentResources",
                                  @"3": @"SecondHouses",
                                  @"4": @"ItvArticle",
                                  };
    
    NSArray *parametersArray = [accumulateIdentification componentsSeparatedByString:@","];
    
    
    NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma", parametersArray[0],@"tableId",parametersArray[1],@"id",parametersArray[2],@"field",[NSString stringWithFormat:@"%d", num],@"num",nil];
    
    
    DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        NSMutableArray* mutableFetchResult= [self getAccumulateRecord:accumulateIdentification];
        NumCacheEntitie* cache = (NumCacheEntitie*)mutableFetchResult[0];
        NSError* error;
        
        if ([[methodResult objectForKey:@"code"] isEqualToString:@"170100"]) {
            [cache setCreate_at:[NSDate date]];
            //清除累计缓存
            [self.myAppDelegate.managedObjectContext deleteObject:cache];
            [self.myAppDelegate.managedObjectContext save:&error];
            
            //清除详情缓存
            NSDictionary *NSDparameter = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",parametersArray[1],@"id",nil];

            NSMutableArray* cacheMutableFetchResult = [self getCacheData:[MainService getRequestIdentification:[tableIdDict objectForKey: parametersArray[0]] withMethod:@"getSingleInfo"] withParameters:[MainService formatToJsonString:NSDparameter]];
            if(!error){
                for(CacheEntities*object in cacheMutableFetchResult) {
                    [self.myAppDelegate.managedObjectContext deleteObject:object];
                }
            }
            if([self.myAppDelegate.managedObjectContext hasChanges]) {
                [self.myAppDelegate.managedObjectContext save:&error];
            }
            //清除拉黑，拨打，收藏的记录缓存
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription* cacheEntity=[NSEntityDescription entityForName:@"NumCacheEntitie" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
            [request setEntity:cacheEntity];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identification  LIKE %@",[NSString stringWithFormat:@"%@,%@,d_*",parametersArray[0],parametersArray[1]]];
            [request setPredicate:predicate];
            NSError* error=nil;
            NSMutableArray* mutableFetchResultTwo=[[self.myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
            if(!error){
                for(CacheEntities*object in mutableFetchResultTwo) {
                    [self.myAppDelegate.managedObjectContext deleteObject:object];
                }
            }
            if([self.myAppDelegate.managedObjectContext hasChanges]) {
                [self.myAppDelegate.managedObjectContext save:&error];
            }
            
            
            
            
        }else{
            [cache setAccumulate_num:[NSNumber numberWithInt:num+1]];
            [cache setUpdate_at:[NSDate date]];
            [self.myAppDelegate.managedObjectContext save:&error];
        }
        
    };
    
    NSURL *NSURLString = [NSURL URLWithString:[@"http://121.42.43.165/Home/" stringByAppendingString:@"Cache"]];
    
    NSString *parameters = [MainService formatToJsonString:condition];
    
    DSJSONRPC *jsonRPC = [[DSJSONRPC alloc] initWithServiceEndpoint:NSURLString];
    
    [jsonRPC callMethod:@"accumulateUpdate" withParameters:parameters onCompletion:completionHandler];
    
    
}

//获得累计记录
-(NSMutableArray*)getAccumulateRecord:(NSString *)AccumulateIdentification{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* cacheEntity=[NSEntityDescription entityForName:@"NumCacheEntitie" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
    [request setEntity:cacheEntity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identification=%@",AccumulateIdentification];
    [request setPredicate:predicate];
    
    NSError* error=nil;
    NSMutableArray* mutableFetchResult=[[self.myAppDelegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    return mutableFetchResult;
    
}





#pragma mark 其他服务


//NSDictionary转NSString
+ (NSString *)formatToJsonString:(NSDictionary *)certificate {
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:certificate options:NSJSONWritingPrettyPrinted error:&error];
    NSString *json =[[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return json;
}
//NSString转NSDictionary
+ (NSDictionary *)JsonStringToDictionary:(NSString *)jsonString{
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *resultsDictionary = [jsonData objectFromJSONData];
    return resultsDictionary;
}

//将日期转换成距离现在得时间
+ (NSString *)becomeDiffTime:(NSString *)inputTime {
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *beforeYesterday, *yesterday;
    
    beforeYesterday = [today dateByAddingTimeInterval: -2*secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * beforeYesterdayString = [[beforeYesterday description] substringToIndex:10];
    
    NSString * dateString = [[inputTime description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:beforeYesterdayString])
    {
        return @"前天";
    }
    else
    {
        return [[dateString description] substringFromIndex:5];
    }
}

+ (NSString *)becomeCallDiffTime:(NSString *)inputTime {
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *beforeYesterday, *yesterday;
    
    beforeYesterday = [today dateByAddingTimeInterval: -2*secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * beforeYesterdayString = [[beforeYesterday description] substringToIndex:10];
    
    NSString * dateString = [[inputTime description] substringToIndex:10];
    NSString * timeString = [[inputTime description] substringFromIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return [@"今天\n" stringByAppendingString:timeString];
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return [@"昨天\n" stringByAppendingString:timeString];
    }else if ([dateString isEqualToString:beforeYesterdayString])
    {
        return [@"前天\n" stringByAppendingString:timeString];
    }
    else
    {
        return [[[dateString description] stringByAppendingString:@"\n"] stringByAppendingString:timeString];
    }
    
}

+(NSDictionary *) getHome {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"ifUseSettedHome"] boolValue]?[[NSUserDefaults standardUserDefaults] objectForKey:@"settedHome"]:[[NSUserDefaults standardUserDefaults] objectForKey:@"home"];
}

+ (UIImage*) getHouseImage:(NSString*)houseType {
    if (([houseType rangeOfString:@"1室"].location != NSNotFound)||([houseType rangeOfString:@"一室"].location != NSNotFound)) {
        return [UIImage imageNamed:@"one_room"];
    }else if(([houseType rangeOfString:@"2室"].location != NSNotFound)||([houseType rangeOfString:@"二室"].location != NSNotFound)){
        return [UIImage imageNamed:@"two_room"];
    }else if(([houseType rangeOfString:@"3室"].location != NSNotFound)||([houseType rangeOfString:@"三室"].location != NSNotFound)){
        return [UIImage imageNamed:@"three_room"];
    }else{
        return [UIImage imageNamed:@"Default-Bg.jpg"];
    }
}




@end
