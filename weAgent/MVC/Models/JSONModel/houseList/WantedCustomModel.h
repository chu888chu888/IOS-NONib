//
//  RentCustomListModel.h
//  weAgent
//
//  Created by apple on 14/11/11.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//


#import "WantedListModel.h"
@interface WantedCustomModel : GlobalModel

@property (strong, nonatomic) NSString<Index>* id;
@property (strong, nonatomic) NSString* follow_type;
@property (strong, nonatomic) NSString* wanted_id;
@property (strong, nonatomic) NSString* note;
@property (strong, nonatomic) NSString* create_at;
@property (strong, nonatomic) NSString* update_at;
@property (strong, nonatomic) NSString* deleted;
@property (strong, nonatomic) NSString* tenant_id;
@property (strong, nonatomic) NSString* user_id;
@property (strong, nonatomic) WantedListModel* wanted;

@end
