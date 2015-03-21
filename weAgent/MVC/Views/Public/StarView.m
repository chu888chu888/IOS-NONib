//
//  StarView.m
//  weAgent
//
//  Created by apple on 14/12/1.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "StarView.h"
#import "UIFont+base.h"
#import "UIColor+base.h"

@implementation StarView

- (id)initWithTrustRate:(float)trustRate
{
    self = [super initWithFrame:CGRectMake(0, 0, 150, 20)];
    if (self) {
        // Initialization code
        self.trustRate =trustRate;
        [self initialize];
       
    }
    return self;
}

- (void) initialize
{
    UIImageView *starView;
    float left = 10.0;
    int rateTemp = self.trustRate;
    
    for (int i=0; i<5; i++) {
        starView = [[UIImageView alloc] initWithFrame:CGRectMake(left, 3.0, 14,14)];
        if (rateTemp>10) {
            if (self.trustRate > 60) {
                [starView setImage:[UIImage imageNamed:@"greenStar"]];
            }else{
                [starView setImage:[UIImage imageNamed:@"redStar"]];
            }
            
        }else if ((rateTemp<=10)&&(rateTemp>0)){
            if (self.trustRate > 60) {
                [starView setImage:[UIImage imageNamed:@"greenStarF"]];
            }else{
                [starView setImage:[UIImage imageNamed:@"redStarF"]];
            }
        }else{
            [starView setImage:[UIImage imageNamed:@"starE"]];
        }
        [self addSubview:starView];
        left+= 15.0;
        rateTemp-=20;
    }
    
    UILabel *rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(left+5, 0.0, 70,20)];
    rateLabel.text = [[NSString stringWithFormat:@"%.1lf",self.trustRate] stringByAppendingString:@"%"];
    rateLabel.textColor = self.trustRate > 60?[UIColor colorWithHexString:@"75cc64"]:[UIColor orangeColor];
    rateLabel.font = [UIFont baseWithSize:12];
    [self addSubview:rateLabel];

}



@end
