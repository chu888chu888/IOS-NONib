//
//  RentInfoModel.h
//  weAgent
//
//  Created by apple on 14-10-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GlobalModel.h"
//声明协议
@protocol RentListModel @end
@interface RentListModel : GlobalModel
//标示该属性被忽略，就算json中有这个字段，生成的模型里也不会有改字段
//@property (strong, nonatomic) NSString<Ignore>;* propertyName;

//标示该属性可选择，json中为null也不会报错
//@property (strong, nonatomic) NSString<Optional>;* propertyName;

//标示该属性为主属性，相当于数据库的主键
//@property (strong, nonatomic) NSString<Index>;* propertyName;


@property (strong, nonatomic) NSString* name;

//除了基本属性，也支持用模型作为属性：
//@property (strong, nonatomic) ProductModel* product;
//当然也可以是模型数组：
//@property (strong, nonatomic) NSArray<ProductModel>* products;
//对象数组懒加载（初始化）,个人理解,应该是延时初始化，优化性能用得:
//@property (strong, nonatomic) NSArray<ProductModel, ConvertOnDemand>* products;

//@property (strong, nonatomic) NSString* excepttime;
@property (strong, nonatomic) NSString* phone;
@property (strong, nonatomic) NSString* rent;
//@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* publish_time;
//@property (strong, nonatomic) NSString* contact_type;
@property (strong, nonatomic) NSString* pic_url;
//@property (strong, nonatomic) NSString* page_title;
//@property (strong, nonatomic) NSString* click_num;
//@property (strong, nonatomic) NSString* collect_num;
//@property (strong, nonatomic) NSString* call_num;
//@property (strong, nonatomic) NSString* block_num;
@property (nonatomic) float trust_degree;
//@property (strong, nonatomic) NSString* discribe;
//@property (strong, nonatomic) NSString* isCollect;
//@property (strong, nonatomic) NSString* payment;
@property (strong, nonatomic) NSString* rent_type;
@property (strong, nonatomic) NSString* area;
//@property (strong, nonatomic) NSString* decorate;
//@property (strong, nonatomic) NSString* base;
@property (strong, nonatomic) NSString* house_type;
//@property (strong, nonatomic) NSString* direction;
//@property (strong, nonatomic) NSString* floor;
//@property (strong, nonatomic) NSString* house;
//@property (strong, nonatomic) NSString* collectId;


@end



