//
//  CalendarViewController.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/8.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)dealloc
{
    NSLog(@"%@:%s", self.class.description, __FUNCTION__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"FSCalendar日历组件";
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1.0];
    self.view = view;
    
    // 450 for iPad and 300 for iPhone
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, view.frame.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    [calendar selectDate:[calendar dateWithYear:2015 month:2 day:6]];
    calendar.backgroundColor = [UIColor whiteColor];
    [view addSubview:calendar];
    self.calendar = calendar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date
{
    NSLog(@"should select date %@",[calendar stringFromDate:date format:@"yyyy/MM/dd"]);
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSLog(@"did select date %@",[calendar stringFromDate:date format:@"yyyy/MM/dd"]);
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to page %@",[calendar stringFromDate:calendar.currentPage format:@"MMMM YYYY"]);
}



@end
