//
//  HouseFiltrate.m
//  weAgent
//
//  Created by apple on 14/12/2.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "HouseFiltrate.h"

@implementation HouseFiltrate

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize
{
    
    [self addListView];
    [self addCompleteView];

}

-(void) addListView{
    _listView = [[GlobalUITableView alloc] initWithFrame:CGRectMake(0, 0,[UIView globalWidth],[UIView globalHeight]-104 ) style:UITableViewStylePlain];
//    _listView.userInteractionEnabled = NO;
//    _listView.cancelsTouchesInView = NO;
    [_listView setBackgroundColor:[UIColor colorWithHexString:@"f7f7f7"]];
    [self addSubview:_listView];
}


//加完成
- (void) addCompleteView
{
    UIView *completeView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIView globalHeight]-104, [UIView globalWidth], 60)];

    
    _completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(([UIView globalWidth]-120), 10, 100, 40)];
    [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_completeBtn beBlue];
    _completeBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [completeView addSubview:_completeBtn];
    
    [self addSubview:completeView];
}




@end
