//
//  CalendarViewController.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/8.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CommonViewController.h"
#import "FSCalendar.h"
@interface CalendarViewController : CommonViewController<FSCalendarDataSource, FSCalendarDelegate>
@property (weak, nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) NSDictionary *images;@end
