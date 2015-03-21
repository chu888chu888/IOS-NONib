//
//  LocationMapViewController.m
//  weAgent
//
//  Created by apple on 14/12/10.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "LocationMapViewController.h"
#import "UIView+base.h"
@interface LocationMapViewController () {
    BMKMapView* _mapView;
    BMKPointAnnotation* HousePoint;
    BMKLocationService* _locService;
}

@end

@implementation LocationMapViewController

//初始化数据
- (id)initWithHousePoint:(BMKPointAnnotation*)houseLocation
{
    if ((self = [super init])) {
        HousePoint=houseLocation;
    }
    return self;
}

//初始化具体 这个方法会在load之后执行
-(void) initialize{
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"找到它"];
    
    //定位服务
    _locService = [[BMKLocationService alloc]init];
    
    //初始化地图
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, [UIView globalWidth], [UIView globalHeight]-44)];
    _mapView.zoomLevel= 14;
    _mapView.minZoomLevel= 10;
    [self.view addSubview:_mapView];

    HousePoint.title = @"它的位置";
    
    [_mapView addAnnotation:HousePoint];
    _mapView.centerCoordinate=HousePoint.coordinate;

}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    [self startLocation];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    
    //将用户地址更新
    NSMutableDictionary *home = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%f",_locService.userLocation.location.coordinate.longitude],@"longitude",[NSString stringWithFormat:@"%f",_locService.userLocation.location.coordinate.latitude],@"latitude",nil];
    [[NSUserDefaults standardUserDefaults] setObject:home forKey:@"home"];
    
    [self stopLocation];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;    
}

#pragma mark 定位相关
//开始定位
-(void)startLocation
{
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

//停止定位
-(void)stopLocation
{
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
}


@end
