//
//  NumCacheEntitie.h
//  weAgent
//
//  Created by apple on 14/12/11.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NumCacheEntitie : NSManagedObject

@property (nonatomic, retain) NSNumber * accumulate_num;
@property (nonatomic, retain) NSDate * create_at;
@property (nonatomic, retain) NSString * identification;
@property (nonatomic, retain) NSNumber * is_vaild;
@property (nonatomic, retain) NSDate * update_at;

@end
