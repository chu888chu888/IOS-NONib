//
//  MYCustomPanel.m
//  MYBlurIntroductionView-Example
//
//  Created by Matthew York on 10/17/13.
//  Copyright (c) 2013 Matthew York. All rights reserved.
//

#import "GuideFour.h"
#import "MYBlurIntroductionView.h"
#import "UIView+base.h"
#import "UIColor+base.h"

@implementation GuideFour

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Interaction Methods
//Override them if you want them!

-(void)panelDidAppear{
//    [self.parentIntroductionView setEnabled:NO];
    self.parentIntroductionView.RightSkipButton.hidden = NO;
    self.parentIntroductionView.RightSkipButton.titleLabel.text = @"跳过";
    self.parentIntroductionView.MasterScrollView.contentSize = CGSizeMake([UIView globalWidth]*4, [UIView globalHeight]);
    self.parentIntroductionView.MasterScrollView.bounces = NO;
    [self.parentIntroductionView.RightSkipButton setTitleColor:[UIColor baseColor] forState:UIControlStateNormal];
}

-(void)panelDidDisappear{
   
}

#pragma mark Outlets




@end
