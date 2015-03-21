//
//  HomeViewController.m
//  weAgent
//
//  Created by 王拓 on 14/11/24.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "HomeViewController.h"
#import "LoadingView.h"
#import "RadarSetViewController.h"
#import "ForRentTableViewController.h"
#import "RentTableViewController.h"
#import "SecondHousesTableViewController.h"
#import "AchievementHomeViewController.h"
#import "CustomerViewController.h"
#import "Reachability.h"
#import "FSBasicImage.h"
#import "FSBasicImageSource.h"

@interface HomeViewController () {
    LoadingView *loadingView;
    BMKLocationService* _locService;
}

@property (nonatomic, strong) Reachability *conn;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
     _locService = [[BMKLocationService alloc]init];
    
    //开启网络实时监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
    //先执行一次网络判断
    [self networkStateChange];
    
    UITapGestureRecognizer *recognizer;
    recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchViewTap)];
    [self.view.searchView addGestureRecognizer:recognizer];
    
    self.view.imagePager.pageControl.pageIndicatorTintColor = [UIColor redColor];
    
    self.view.imagePager.userInteractionEnabled=YES;
    UITapGestureRecognizer *imageTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewPic)];
    [ self.view.imagePager addGestureRecognizer:imageTap];
    
    UITapGestureRecognizer *helpTap;
    helpTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(helpViewTap)];
    [self.view.helpBtn addGestureRecognizer:helpTap];

    
}

- (void)loadView{
    self.view = [[Home alloc]init];
    self.view.imagePager.dataSource = self;
    self.view.imagePager.delegate = self;
    [self.view.radarBtn addTarget:self action:@selector(radarBtnHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.homeSetBtn addTarget:self action:@selector(homeSetBtnHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.homeWantedBtn addTarget:self action:@selector(homeWantedBtnHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.homeRentBtn addTarget:self action:@selector(homeRentBtnHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.homeSecondBtn addTarget:self action:@selector(homeSecondBtnHandle) forControlEvents:UIControlEventTouchUpInside];
     [self.view.homeAchieveBtn addTarget:self action:@selector(homeAchieveBtnHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.homeCollectBtn addTarget:self action:@selector(homeCollectBtnHandle) forControlEvents:UIControlEventTouchUpInside];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   

    //这里使动画动起来
    self.view.imagePager.pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    self.view.imagePager.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    self.view.imagePager.slideshowTimeInterval = 5.5f;
    self.view.imagePager.slideshowShouldCallScrollToDelegate = YES;
    
    //设置米和天数
    self.view.timeValueLab.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"beforeDay"] stringByAppendingString:@"天"];
    self.view.distanceValueLab.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"distance"] stringByAppendingString:@"米"];
}

-(void)viewWillAppear:(BOOL)animated
{
    //开始定位
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"ifUseSettedHome"] boolValue])
    {
        _locService.delegate = self;
        [_locService startUserLocationService];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"ifUseSettedHome"] boolValue])
    {
        _locService.delegate = nil;
    }
}

#pragma mark - 网络实时监控
- (void)networkStateChange
{
    //检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    if ([conn currentReachabilityStatus] != NotReachable) {
        // 没有使用wifi, 使用手机自带网络进行上网
        if (!self.view.noNetView.isHidden) {
            self.view.noNetView.hidden = YES;
            [self.view.linearLayoutView setFrame:CGRectMake(self.view.linearLayoutView.frame.origin.x, self.view.linearLayoutView.frame.origin.y - 40, self.view.linearLayoutView.frame.size.width, self.view.linearLayoutView.frame.size.height)];
        }

    } else {
        // 没有网络
        if (self.view.noNetView.isHidden) {
            [self.view addNoNetView];
        }
    }
}


#pragma mark - 定位服务
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    NSMutableDictionary *home = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude],@"longitude",[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude],@"latitude",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:home forKey:@"home"];
    
    [_locService stopUserLocationService];
    
}

#pragma mark - 点击事件
/**
 *  雷达设置点击
 */
- (void)homeSetBtnHandle{
    RadarSetViewController *radarSetVC = [[RadarSetViewController alloc] init];
    radarSetVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:radarSetVC animated:YES];
}

- (void)homeCollectBtnHandle{
    CustomerViewController *customerHomeVC = [[CustomerViewController alloc] init];
    customerHomeVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:customerHomeVC animated:YES];
}

- (void)homeWantedBtnHandle{
    ForRentTableViewController *radarSetVC = [[ForRentTableViewController alloc] init];
    radarSetVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:radarSetVC animated:YES];
}

- (void)homeRentBtnHandle{
    RentTableViewController *radarSetVC = [[RentTableViewController alloc] init];
    radarSetVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:radarSetVC animated:YES];
}

- (void)homeSecondBtnHandle{
    SecondHousesTableViewController *radarSetVC = [[SecondHousesTableViewController alloc] init];
    radarSetVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:radarSetVC animated:YES];
}
/**
 *  我的业绩点击
 */
- (void)homeAchieveBtnHandle{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] == nil || [[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] isEqualToString:@""]) {
        [self loginHandle];
        return;
    }
    AchievementHomeViewController *AchievementVC = [[AchievementHomeViewController alloc] init];
    AchievementVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:AchievementVC animated:YES];
}

//点击一键搜索
- (void)radarBtnHandle{
    NSDictionary *NSDparameters = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",[MainService getHome],@"home",@"0",@"moneyRange",[[NSUserDefaults standardUserDefaults] objectForKey:@"beforeDay"],@"beforeDay",[[NSUserDefaults standardUserDefaults] objectForKey:@"distance"],@"distance",nil];
    
    //开始动画
    [self startRepeatingTimer];
    
    DSJSONRPCCompletionHandler onCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            self.view.wantedNum.text= [[methodResult objectForKey:@"result"] objectForKey:@"wantedNum"];
            self.view.rentNum.text= [[methodResult objectForKey:@"result"] objectForKey:@"rentNum"];
            self.view.secondNum.text= [[methodResult objectForKey:@"result"] objectForKey:@"secondNum"];
            self.view.searchLab.text = @"搜索完成";
        };
        
     
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
        
        [self stopRepeatingTimer];
    

        if (![self.view.searchLab.text isEqualToString:@"搜索完成"]) {
            self.view.searchLab.text = @"搜索失败";
        }
        [self.view.radarBtn setEnabled:YES];
        
    };
    //延时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self RPCUseClass:@"Mix" callMethodName:@"getRadarNumbers" withParameters:NSDparameters onCompletion:onCompletionHandler];
    });
    
    [self.view.radarBtn setEnabled:NO];
                   
}



#pragma mark - 动画实现
- (void)startRepeatingTimer {
    //userInfo是参数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self selector:@selector(searchAction)
                                                    userInfo:nil repeats:YES];
    self.repeatingTimer = timer;  
}

- (void)stopRepeatingTimer {
    [self.repeatingTimer invalidate];
    self.repeatingTimer = nil;
}

- (void)searchAction{
    static int loopCount = 0;
    NSArray * searchText = @[@"正在搜索",
                             @"正在搜索.",
                             @"正在搜索..",
                             @"正在搜索..."];
    if(loopCount<4){
        self.view.searchLab.text = searchText[loopCount++];
    }else{
        self.view.searchLab.text = searchText[0];
        loopCount = 0;
    }
}

#pragma mark - KIImagePager DataSource
- (NSArray *) arrayWithImages{
    _photoArray = [NSMutableArray array];
    [_photoArray addObject:[UIImage imageNamed:@"banner1.jpg"]];
    [_photoArray addObject:[UIImage imageNamed:@"banner2.jpg"]];
    [_photoArray addObject:[UIImage imageNamed:@"banner3.jpg"]];
    return _photoArray;
}

- (UIViewContentMode) contentModeForImage:(NSUInteger)image{
    return UIViewContentModeScaleAspectFill;
}

#pragma mark 点击手势事件
- (void) searchViewTap{
    RadarSetViewController *radarSetVC = [[RadarSetViewController alloc] init];
    radarSetVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:radarSetVC animated:YES];
}

-(void)viewPic{

    NSMutableArray *PicArray = [[NSMutableArray array] init];
    for (id picObj in self.photoArray) {
        if([picObj isKindOfClass:[UIImage class]]){
            [PicArray addObject:[[FSBasicImage alloc] initWithImage:picObj]];
        }else{
            [PicArray addObject:[[FSBasicImage alloc] initWithImageURL:[NSURL URLWithString:picObj]]];
        }
    }
    FSBasicImageSource *photoSource = [[FSBasicImageSource alloc] initWithImages:PicArray];
    
    FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:photoSource];
    [imageViewController.titleView hideView:YES];
    [self.navigationController pushViewController:imageViewController animated:YES];
}

-(void) helpViewTap{
    [self.view.helpView removeFromSuperview];
}
@end
