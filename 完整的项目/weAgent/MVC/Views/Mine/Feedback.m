//
//  Feedback.m
//  weAgent
//
//  Created by 王拓 on 14/12/11.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "Feedback.h"

@implementation Feedback

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void) initialize {
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, [UIView globalWidth]-20, 30)];
    titleLab.textColor = [UIColor lightGrayColor];
    titleLab.text = @"感谢您的反馈，我们将不断为您改进";
    titleLab.font = [UIFont baseWithSize:14];
    CSLinearLayoutItem *titleLabItem = [CSLinearLayoutItem layoutItemForView:titleLab];
    titleLabItem.padding = CSLinearLayoutMakePadding(10.0f, 10.0f, 0.0, 10.0);
    titleLabItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:titleLabItem];
    
    _feedbackText = [[UITextView alloc]initWithFrame:CGRectMake(10.0f, 10.0f, [UIView globalWidth]-20, 150)];
    _feedbackText.textColor = [UIColor grayColor];
    _feedbackText.font = [UIFont baseWithSize:14];
    _feedbackText.returnKeyType = UIReturnKeyDefault;
    _feedbackText.layer.borderWidth = 1.0;
    _feedbackText.layer.cornerRadius = 5.0;
    _feedbackText.layer.borderColor=[[UIColor colorWithRed:110/255.0 green:181/255.0 blue:163/255.0 alpha:1] CGColor];
    CSLinearLayoutItem *feedTextItem = [CSLinearLayoutItem layoutItemForView:_feedbackText];
    feedTextItem.padding = CSLinearLayoutMakePadding(0.0f, 10.0f, 0.0, 10.0);
    feedTextItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:feedTextItem];
    
    
    _commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIView globalWidth]-20, 44)];
    [_commitBtn beOrange];
    [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    CSLinearLayoutItem *commitBtnItem = [CSLinearLayoutItem layoutItemForView:_commitBtn];
    commitBtnItem.padding = CSLinearLayoutMakePadding(10.0, 10.0, 0.0, 10.0);
    commitBtnItem.horizontalAlignment = CSLinearLayoutItemHorizontalAlignmentCenter;
    [self.linearLayoutView addItem:commitBtnItem];
    
}

@end
