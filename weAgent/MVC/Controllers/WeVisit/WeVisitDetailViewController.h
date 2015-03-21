//
//  WeVisitDetailViewController.h
//  weAgent
//
//  Created by 王拓 on 14/12/3.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalViewController.h"
#import "WeVisitDetail.h"
#import "UIImageView+AFNetworking.h"

@interface WeVisitDetailViewController : GlobalViewController

@property (nonatomic)WeVisitDetail *view;

@property(nonatomic)NSString *infoId;
- (id)initWithId:(NSString*)infoId;

@end
