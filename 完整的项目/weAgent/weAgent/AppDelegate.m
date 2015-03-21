//
//  AppDelegate.m
//  weAgent
//
//  Created by apple on 14/11/19.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
//#import "NumCacheEntitie.h"
//#import "CacheEntities.h"
//#import "MainService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

# pragma mark - app代理生命周期
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"PdTy5NeHp2z8OFWSkU60H8R3" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //配置友盟统计
    [MobClick startWithAppkey:@"5452f6cefd98c5ca9e0033a5"];
    [MobClick setAppVersion:@"1.0.0"];
    [MobClick setLogEnabled:NO];
    //这个方法是定义发送策略的
//    [MobClick startWithAppkey:@"xxxxxxxxxxxxxxx" reportPolicy:SEND_INTERVAL channelId:@"Web"];
    
    //判断程序是否是第一次运行 marenqing
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"help_one"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    //设置默认天数
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"beforeDay"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"beforeDay"];
    }
    
    //设置默认距离
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"distance"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"3000" forKey:@"distance"];
    }
    
    //设置默认是否使用设置地点
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"ifUseSettedHome"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ifUseSettedHome"];
    }
    
    
    
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        IntroduceViewController *introduceVC = [[IntroduceViewController alloc] init];
        //将跳转委托为自己
        introduceVC.toNextViewDetegate = self;
        self.window.rootViewController = introduceVC;
        
        
    }else{
        
        //实例化rootViewController
        RootViewController *rootVC = [[RootViewController alloc] init];
        self.window.rootViewController = rootVC;
        
    }

    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
//    这里有设计一个一次性跟新数据得接口才行 marenqing
    
//    NSLog(@"234234");
//    //检测缓存数据，将点击数过期的提交给服务器
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    NSEntityDescription* cacheEntity=[NSEntityDescription entityForName:@"NumCacheEntitie" inManagedObjectContext:self.managedObjectContext];
//    [request setEntity:cacheEntity];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identification  LIKE %@",@"*click_num"];
//    [request setPredicate:predicate];
//    NSError* error=nil;
//    NSMutableArray* mutableFetchResultTwo=[[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
//    if(!error){
//        NSDate *datenow = [NSDate date];
//        NSTimeInterval now=[datenow timeIntervalSince1970]*1;
//        NSTimeInterval update;
//        for(NumCacheEntitie*object in mutableFetchResultTwo) {
//            update = [object.update_at timeIntervalSince1970]*1;
//            //一天，这里可能和mainservice不一致，哎，一开始布局就失误
//            if ((now-update)>0) {
//                
//                NSDictionary *tableIdDict = @{
//                                              @"1": @"Wanted",
//                                              @"2": @"RentResources",
//                                              @"3": @"SecondHouses",
//                                              @"4": @"ItvArticle",
//                                              };
//                
//                NSArray *parametersArray = [object.identification componentsSeparatedByString:@","];
//                
//                
//                NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma", parametersArray[0],@"tableId",parametersArray[1],@"id",parametersArray[2],@"field",object.accumulate_num,@"num",nil];
//                
//                
//                DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
//                    
//                    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//                    NSEntityDescription* cacheEntity=[NSEntityDescription entityForName:@"NumCacheEntitie" inManagedObjectContext:self.managedObjectContext];
//                    [request setEntity:cacheEntity];
//                    
//                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identification=%@",object.identification];
//                    [request setPredicate:predicate];
//                    
//                    NSError* error=nil;
//                    NSMutableArray* mutableFetchResult=[[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
//                    
//                    NumCacheEntitie* cache = (NumCacheEntitie*)mutableFetchResult[0];
//                    
//                    if ([[methodResult objectForKey:@"code"] isEqualToString:@"170100"]) {
//                        [cache setCreate_at:[NSDate date]];
//                        //清除累计缓存
//                        [self.managedObjectContext deleteObject:cache];
//                        [self.managedObjectContext save:&error];
//                        
//                        //清除详情缓存
//                        NSDictionary *NSDparameter = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",parametersArray[1],@"id",nil];
//                        
//                        NSEntityDescription* cacheEntity=[NSEntityDescription entityForName:@"CacheEntities" inManagedObjectContext:self.managedObjectContext];
//                        [request setEntity:cacheEntity];
//                        
//                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identification=%@,getSingleInfo,%@",[tableIdDict objectForKey:parametersArray[0]],[MainService formatToJsonString:NSDparameter]];
//                        [request setPredicate:predicate];
//                        
//                        NSMutableArray* cacheMutableFetchResult=[[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
//                        
//                        if(!error){
//                            for(CacheEntities*object in cacheMutableFetchResult) {
//                                [self.managedObjectContext deleteObject:object];
//                            }
//                        }
//                        if([self.managedObjectContext hasChanges]) {
//                            [self.managedObjectContext save:&error];
//                        }
//                        //清除拉黑，拨打，收藏的记录缓存
//                        NSEntityDescription* cacheEntityT=[NSEntityDescription entityForName:@"NumCacheEntitie" inManagedObjectContext:self.managedObjectContext];
//                        [request setEntity:cacheEntityT];
//                        NSPredicate *predicateT = [NSPredicate predicateWithFormat:@"identification  LIKE %@",[NSString stringWithFormat:@"%@,%@,d_*",parametersArray[0],parametersArray[1]]];
//                        [request setPredicate:predicateT];
//                        NSMutableArray* mutableFetchResultTwo=[[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
//                        if(!error){
//                            for(CacheEntities*object in mutableFetchResultTwo) {
//                                [self.managedObjectContext deleteObject:object];
//                            }
//                        }
//                        if([self.managedObjectContext hasChanges]) {
//                            [self.managedObjectContext save:&error];
//                        }
//                        
//                    }
//                };
//                
//                NSURL *NSURLString = [NSURL URLWithString:[@"http://121.42.43.165/Home/" stringByAppendingString:@"Cache"]];
//                
//                NSString *parameters = [MainService formatToJsonString:condition];
//                
//                DSJSONRPC *jsonRPC = [[DSJSONRPC alloc] initWithServiceEndpoint:NSURLString];
//                
//                [jsonRPC callMethod:@"accumulateUpdate" withParameters:parameters onCompletion:completionHandler];
//                
//            }
//        }
//    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - 跳转代理方法
-(void)toNextView{
    RootViewController *rootVC = [[RootViewController alloc] init];
    self.window.rootViewController = rootVC;
}


#pragma mark - Core Data 相关

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "weAgent.weAgent" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"weAgent" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"weAgent.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
