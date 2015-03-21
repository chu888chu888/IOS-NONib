//
//  CacheEntities.h
//  weAgent
//
//  Created by apple on 14/11/21.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CacheEntities : NSManagedObject

@property (nonatomic, retain) NSDate * create_at;
@property (nonatomic, retain) NSString * data_cache;
@property (nonatomic, retain) NSString * identification;
@property (nonatomic, retain) NSNumber * is_vaild;
@property (nonatomic, retain) NSDate * update_at;

@end
