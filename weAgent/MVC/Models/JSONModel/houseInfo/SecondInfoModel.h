//
//  SecondInfoModel.h
//  weAgent
//
//  Created by apple on 14-10-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GlobalModel.h"


@interface SecondInfoModel : GlobalModel

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* excepttime;
@property (strong, nonatomic) NSString* phone;
@property (strong, nonatomic) NSString* price;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* publish_time;
@property (strong, nonatomic) NSString* contact_type;
@property (strong, nonatomic) NSArray* pic_url;
@property (strong, nonatomic) NSString* page_title;
@property (strong, nonatomic) NSString* click_num;
@property (strong, nonatomic) NSString* collect_num;
@property (strong, nonatomic) NSString* call_num;
@property (strong, nonatomic) NSString* block_num;
@property (nonatomic) float trust_degree;
@property (strong, nonatomic) NSString* discribe;
@property (strong, nonatomic) NSString* isCollect;
@property (strong, nonatomic) NSString* payment;
@property (strong, nonatomic) NSString* rent_type;
@property (strong, nonatomic) NSString* area;
@property (strong, nonatomic) NSString* decorate;
@property (strong, nonatomic) NSString* base;
@property (strong, nonatomic) NSString* house_type;
@property (strong, nonatomic) NSString* direction;
@property (strong, nonatomic) NSString* floor;
@property (strong, nonatomic) NSString* house;
@property (strong, nonatomic) NSString* collectId;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

@end
