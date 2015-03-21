//
//  AppDelegate.h
//  weAgent
//
//  Created by apple on 14/11/19.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DSJSONRPC.h"
#import "IntroduceViewController.h"
#import "BMapKit.h"
#import "MobClick.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,NextViewDelegate,BMKGeneralDelegate> {
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

#pragma mark - coreData相关
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

