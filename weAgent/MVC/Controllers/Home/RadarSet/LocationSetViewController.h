//
//  LocationSetViewController.h
//  weAgent
//
//  Created by apple on 14/12/8.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalViewController.h"

@interface LocationSetViewController : GlobalViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property (nonatomic) UILabel *alertLab;

@end
