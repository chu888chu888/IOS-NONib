//
//  GraphViewController.m
//  weChat
//
//  Created by apple on 14-8-29.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "AchievementHomeViewController.h"
#import "LoadingView.h"

@interface AchievementHomeViewController (){
    LoadingView *loadingView;
    int days;
}

@end

@implementation AchievementHomeViewController

-(void)loadView{
    self.view = [[AchievementView alloc] init];
    self.view.achievementGraph.delegate = self;
    self.view.achievementGraph.dataSource = self;
    days = 19;
    self.ArrayOfValues = [[NSMutableArray alloc] init];
    self.ArrayOfDates = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"业绩"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    loadingView = [[LoadingView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:loadingView];
    [self initialize];
}

-(void) initialize{
    NSDictionary *NSDparameters = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",[NSString stringWithFormat:@"%d",days],@"days",nil];
    
    DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            [self.ArrayOfValues removeAllObjects];
            [self.ArrayOfDates removeAllObjects];
            for (int i = days-1; i >= 0; i--) {
                [self.ArrayOfValues addObject:[NSNumber numberWithInteger:[[[[[methodResult objectForKey:@"result"] objectForKey:@"dayCallNum"] objectAtIndex:i] objectForKey:@"number"] integerValue]]];
                
                [self.ArrayOfDates addObject:[NSString stringWithFormat:@"%@",[[[[methodResult objectForKey:@"result"] objectForKey:@"dayCallNum"] objectAtIndex:i] objectForKey:@"day"]]];
            }
            
            self.view.dayRadialView.progressCounter =[[[methodResult objectForKey:@"result"] objectForKey:@"dayRate"] integerValue];
            self.view.monthRadialView.progressCounter =[[[methodResult objectForKey:@"result"] objectForKey:@"monthRate"] integerValue];
            self.view.thisWeekNum.text =[[methodResult objectForKey:@"result"] objectForKey:@"weekTotal"];
            self.view.todayNum.text =[[methodResult objectForKey:@"result"] objectForKey:@"dayTotal"];
            self.view.totalNum.text =[[methodResult objectForKey:@"result"] objectForKey:@"callTotal"];
            
            [self.view.achievementGraph reloadGraph];
        };
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
        [loadingView removeFromSuperview];

        
        
    };
    
    //延时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self RPCUseClass:@"Call" callMethodName:@"getAchievements" withParameters:NSDparameters onCompletion:completionHandler];
    });
    
    
}

- (NSInteger)getRandomInteger
{
    NSInteger i1 = (int)(arc4random() % 10000);
    return i1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return (int)[self.ArrayOfValues count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[self.ArrayOfValues objectAtIndex:index] floatValue];
}

#pragma mark - SimpleLineGraph Delegate
- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 1;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
 
    return [[[self.ArrayOfDates objectAtIndex:index] description] substringFromIndex:5] ;
}

//下面是操作图表得各种事件触发
- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    
}
- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
    
}

@end
