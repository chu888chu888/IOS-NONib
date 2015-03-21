//
//  StarView.h
//  weAgent
//
//  Created by apple on 14/12/1.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView
- (id)initWithTrustRate:(float)trustRate;
@property (nonatomic) float trustRate;
@end
