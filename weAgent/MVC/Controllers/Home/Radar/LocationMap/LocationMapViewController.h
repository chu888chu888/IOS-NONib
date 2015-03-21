//
//  LocationMapViewController.h
//  weAgent
//
//  Created by apple on 14/12/10.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalViewController.h"

@interface LocationMapViewController : GlobalViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>
- (id)initWithHousePoint:(BMKPointAnnotation*)houseLocation;
@end

