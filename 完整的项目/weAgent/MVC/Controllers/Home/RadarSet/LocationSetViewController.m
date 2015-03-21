//
//  LocationSetViewController.m
//  weAgent
//
//  Created by apple on 14/12/8.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "LocationSetViewController.h"
#import "UIView+base.h"
#import <QuartzCore/QuartzCore.h>
@interface LocationSetViewController (){
    BMKMapView* _mapView;
    BMKPointAnnotation* locationSetPoint;
    BMKPointAnnotation* settedPoint;
    BMKLocationService* _locService;
}

@end

@implementation LocationSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"定位设置"];
    
    //加完成按钮
    UIBarButtonItem *customRightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(setLocation)];
    self.navigationItem.rightBarButtonItem = customRightBarButtonItem;
    
    //初始化地图
    locationSetPoint = [[BMKPointAnnotation alloc]init];
    settedPoint = [[BMKPointAnnotation alloc]init];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, [UIView globalWidth], [UIView globalHeight]-44)];
    _mapView.zoomLevel= 14;
    _mapView.minZoomLevel= 10;
    [self.view addSubview:_mapView];
    
    //添加当前设置点
    [self addSettetPoint];
    
    //添加提示框
    [self addAlert];
    
    //定位服务
    _locService = [[BMKLocationService alloc]init];
    
    //增加回到我的位置按钮
    UIButton* mime=[[UIButton alloc] initWithFrame:CGRectMake(5, [UIView globalHeight]-100, 30, 30)];
    mime.titleLabel.text=@"我的位置";
    mime.backgroundColor=[UIColor clearColor];
    
    [mime setBackgroundImage:[UIImage imageNamed:@"bnavi_icon_location_fixed@2x.png"] forState:UIControlStateNormal];
    mime.backgroundColor=[UIColor whiteColor];
    [mime addTarget:self action:@selector(backToMyPosition) forControlEvents:1];
    [self.view addSubview:mime];
    
    //    UIImage * location= [UIImage imageNamed:@"bnavi_icon_location_fixed.png"];
    //    UIImageView *lo =[[UIImageView alloc] initWithImage:location];
    //    [lo setFrame:CGRectMake(122, 220, 300, 200)];
    //    //lo.backgroundColor=[UIColor blackColor];
    //    [self.view addSubview:lo];
    //    //mapView.centerCoordinate = userLocation.location.coordinate;
    
}
//回到我的位置
-(void)backToMyPosition{
    UIAlertView *info =[[UIAlertView alloc] init];
    info.message=@"您禁用了定位服务,请在设置->隐私->定位中设置";
    info.title=@"提示";
    [info addButtonWithTitle:@"确定"];
    
    if(_locService.userLocation.updating||_locService.userLocation.location ==nil){
        [self startLocation];
        [info show];
    }else{
        _mapView.centerCoordinate=_locService.userLocation.location.coordinate;
        NSLog(@"回到中心");
    }
    
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

#pragma mark 底图手势操作
/**
 *点中底图标注后会回调此接口
 *@param mapview 地图View
 *@param mapPoi 标注点信息
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{
    [_mapView removeAnnotation:locationSetPoint];
    
    CLLocationCoordinate2D pt = mapPoi.pt;
    locationSetPoint.coordinate = pt;
    locationSetPoint.title = @"您将设置的搜索点";
    
    [_mapView addAnnotation:locationSetPoint];
}
/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    
    [_mapView removeAnnotation:locationSetPoint];
    
    CLLocationCoordinate2D pt = coordinate;
    locationSetPoint.coordinate = pt;
    locationSetPoint.title = @"点击确定提交设置";
    
    _alertLab.text=@"点击确定提交设置";
    
    [_mapView removeAnnotation:settedPoint];
    [_mapView addAnnotation:locationSetPoint];
    
}


#pragma mark 添加标注
/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"LocationSet";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    // 设置位置
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    //    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}

#pragma mark 定位相关
-(void)startLocation
{
    [_locService startUserLocationService];
    //    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    //    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    //    _mapView.showsUserLocation = YES;//显示定位图层
    
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    //    NSLog(@"stop locate");
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

#pragma mark 各种方法
//完成设置
-(void)setLocation
{
    NSMutableDictionary *settedHome = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%f",locationSetPoint.coordinate.longitude],@"longitude",[NSString stringWithFormat:@"%f",locationSetPoint.coordinate.latitude],@"latitude",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:settedHome forKey:@"settedHome"];
    
    [_mapView removeAnnotation:locationSetPoint];
    [_mapView removeAnnotation:settedPoint];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//添加设置点
-(void)addSettetPoint{
    CLLocationCoordinate2D coor;
    coor.latitude = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"settedHome"] objectForKey:@"latitude"] doubleValue];
    coor.longitude = [[[[NSUserDefaults standardUserDefaults] objectForKey:@"settedHome"] objectForKey:@"longitude"] doubleValue];
    settedPoint.coordinate = coor;
    settedPoint.title = @"您已经设置的搜索点";
    _mapView.centerCoordinate=coor;
    [_mapView addAnnotation:settedPoint];
}


-(void)addAlert{
    _alertLab = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 10.0f, 130.0f, 24.0f)];
    [_alertLab setBackgroundColor:[UIColor lightGrayColor]];
    _alertLab.text = @"点击地图设置位置";
    _alertLab.font = [UIFont baseWithSize:14];
    _alertLab.textColor = [UIColor whiteColor];
    _alertLab.textAlignment = NSTextAlignmentCenter;
    _alertLab.center = CGPointMake([UIView globalWidth]*0.5, 20.0f);
    [self.view addSubview:_alertLab];
}

@end
