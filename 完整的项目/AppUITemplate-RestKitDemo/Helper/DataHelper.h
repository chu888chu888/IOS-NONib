//
//  DataHelper.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/11/4.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHelper : NSObject
//格式化好友列表
+(NSMutableArray *)getFriendListDataBy:(NSMutableArray *)array;
+(NSMutableArray *)getFriendListSectionBy:(NSMutableArray *)array;
@end
