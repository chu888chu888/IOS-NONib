//
//  KMMoviePosterCell.m
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 05/02/2014.
//  Copyright (c) 2014 iKode Ltd. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        self.ImageView = [[UIImageView alloc]initWithFrame:
                                     CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
        self.ImageView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:self.ImageView];
        self.contentView.layer.borderWidth=1.0f;
        self.contentView.layer.borderColor=[UIColor whiteColor].CGColor;
        
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

@end
