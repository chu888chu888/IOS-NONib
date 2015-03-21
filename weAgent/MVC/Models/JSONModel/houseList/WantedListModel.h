//
//  RentInfoModel.h
//  weAgent
//
//  Created by apple on 14-10-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GlobalModel.h"
//声明协议
@protocol WantedListModel @end
@interface WantedListModel : GlobalModel

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* phone;
@property (nonatomic) float trust_degree;
@property (strong, nonatomic) NSString* house_type;
@property (strong, nonatomic) NSString* rent;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* publish_time;



@end



