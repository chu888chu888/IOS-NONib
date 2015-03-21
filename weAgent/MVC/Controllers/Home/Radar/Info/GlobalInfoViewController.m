//
//  GlobalInfoViewController.m
//  weChat
//
//  Created by apple on 14-9-29.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "GlobalInfoViewController.h"
#import "LocationMapViewController.h"
#import "FSBasicImage.h"
#import "FSBasicImageSource.h"




@interface GlobalInfoViewController ()

@end

@implementation GlobalInfoViewController
#pragma mark 初始化
//以房子的id进行初始化
- (id)initWithId:(NSString*)showID
{
    if ((self = [super init])) {
        self.showId = showID;
    }
    return self;
}

////加载到数据后初始化接口
//-(void) initialize{
//}

//一系列得初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.imagePager.dataSource = self;
    self.view.imagePager.delegate = self;
    self.view.linearLayoutView.delegate = self;
    
    [self.view.givePhone addTarget:self action:@selector(givePhoneHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.givePhoneCopy addTarget:self action:@selector(givePhoneHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.blockBtn addTarget:self action:@selector(blockHandle) forControlEvents:UIControlEventTouchUpInside];
    
    self.collectButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_merchant_collect"] style:UIBarButtonItemStyleDone target:self action:@selector(collectIt)];
    
    self.collectedButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_merchant_collect_selected"] style:UIBarButtonItemStyleDone target:self action:@selector(discollectIt)];
    self.view.phoneView.hidden = YES;
    self.photoArray = [[NSMutableArray array] init];
    
    //注册地理位置的点击事件
    self.view.goView.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(findIt)];
    [ self.view.goView addGestureRecognizer:singleTap];
    
    //注册图片查看器点击事件
    self.view.imagePager.userInteractionEnabled=YES;
    UITapGestureRecognizer *imageTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewPic)];
    [ self.view.imagePager addGestureRecognizer:imageTap];
    
    
    
    //加载数据
    [self loadData];
   
}

//等待加载数据
- (void)viewWillAppear:(BOOL)animated{
    if (!_HousePoint) {
        self.loadingView = [[LoadingView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.loadingView];
    }
}




#pragma mark 各种点击事件
//收藏函数
-(void)findIt {
    
    LocationMapViewController * locationMapVC = [[LocationMapViewController alloc] initWithHousePoint:_HousePoint];
    locationMapVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:locationMapVC animated:YES];

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




- (void)collectIt{
    NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",self.showId,@"houseId",self.typeId,@"typeId",nil];
    
    DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        if ([[methodResult objectForKey:@"code"] isEqualToString:@"070700"]) {
            //给收藏数加1
            self.view.collectNum.text =  [NSString stringWithFormat:@"%d",([self.view.collectNum.text intValue] + 1)];
            //设置follow，为取消收藏用
            self.followId =[[methodResult objectForKey:@"result"] stringValue];
            //将followId存入数据库
            [self.MainService saveData:methodResult withRequestIdentification:@"Follow,createFollow" andParameters:[MainService formatToJsonString:condition]];
            
            
            self.navigationItem.rightBarButtonItem=self.collectedButton;
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"添加收藏成功!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(removeInfo) userInfo:self.MainService.promptAlert repeats:NO];
             [self.MainService accumulateOnce:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_collect_num"]];
            //清空缓存
            if([self.typeId isEqualToString:@"1"]){
                 [self.MainService deleteCacheWithRequestIdentification:@"Follow,getWantedFollowPage"];
            }else if ([self.typeId isEqualToString:@"2"]){
                [self.MainService deleteCacheWithRequestIdentification:@"Follow,getRentResourcesFollowPage"];
            }else if ([self.typeId isEqualToString:@"3"]) {
                [self.MainService deleteCacheWithRequestIdentification:@"Follow,getSecondFollowPage"];
            }

        }else{
            self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"添加收藏失败!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            
            [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(removeInfo) userInfo:self.MainService.promptAlert repeats:NO];
            
        }
        [self.MainService.promptAlert show];
        
    };
    
    [self RPCUseClass:@"Follow" callMethodName:@"createFollow" withParameters:condition onCompletion:completionHandler];
    
    
}

//取消收藏
- (void)discollectIt{
     NSDictionary *cacheCondition = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",self.showId,@"houseId",self.typeId,@"typeId",nil];
    
      NSMutableArray* mutableFetchResult= [self.MainService getCacheData:@"Follow,createFollow" withParameters:[MainService formatToJsonString:cacheCondition]];
    
    if (!(([mutableFetchResult count] == 0)||(mutableFetchResult == nil))) {         CacheEntities* cache = (CacheEntities*)mutableFetchResult[0];
        NSDictionary *resultsDictionary = [MainService JsonStringToDictionary:cache.data_cache];
        self.followId = [[resultsDictionary objectForKey:@"result"] stringValue];
    }
    
    NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",self.followId,@"id",nil];
    
    DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            if ([[methodResult objectForKey:@"code"] isEqualToString:@"070800"]) {
                self.navigationItem.rightBarButtonItem=self.collectButton;
                //这里我让取消收藏也加一，是为了判断该房源是否已经被收藏
                [self.MainService accumulateOnce:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_collect_num"]];
                
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"取消收藏成功!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
                
                [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(removeInfo) userInfo:self.MainService.promptAlert repeats:NO];
               
                //清空缓存
                if([self.typeId isEqualToString:@"1"]){
                    [self.MainService deleteCacheWithRequestIdentification:@"Follow,getWantedFollowPage"];
                }else if ([self.typeId isEqualToString:@"2"]){
                    [self.MainService deleteCacheWithRequestIdentification:@"Follow,getRentResourcesFollowPage"];
                }else if ([self.typeId isEqualToString:@"3"]) {
                    [self.MainService deleteCacheWithRequestIdentification:@"Follow,getSecondFollowPage"];
                }
            }else{
                self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"取消收藏失败!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
                
                [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(removeInfo) userInfo:self.MainService.promptAlert repeats:NO];
            }
            [self.MainService.promptAlert show];
        };
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:condition onCompletion:RPCMainHandler];
    };
    [self RPCUseClass:@"Follow" callMethodName:@"deleteFollow" withParameters:condition onCompletion:completionHandler];
}

//拨打电话
-(void)givePhoneHandle{
    NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",self.showId,@"houseId",self.typeId,@"typeId",nil];
    
    
    DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        RPCMainHandler RPCMainHandler= ^(id methodResult){
             self.view.callNum.text =  [NSString stringWithFormat:@"%d",([self.view.callNum.text intValue] + 1)];
            [self.MainService accumulateOnce:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_call_num"]];
            //清拨打记录缓存
            [self.MainService deleteCacheWithRequestIdentification:@"Call,getCallRecordsPage"];
            [self.MainService deleteCacheWithRequestIdentification:@"Call,getAchievements"];
            [self callPhone:self.phoneNumber];
            
        };
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:condition onCompletion:RPCMainHandler];
    };
    
    [self RPCUseClass:@"Call" callMethodName:@"createCall" withParameters:condition onCompletion:completionHandler];
}

//拉黑处理
-(void)blockHandle{
    self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"举报后，将推出该界面，是否确认举报!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [self.MainService.promptAlert addButtonWithTitle:@"举报"];
    [self.MainService.promptAlert show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
   if (buttonIndex == 1) {
       NSDictionary *condition = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",self.showId,@"houseId",self.typeId,@"typeId",nil];
       
       DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
           RPCMainHandler RPCMainHandler= ^(id methodResult){
               self.view.blackNum.text =  [NSString stringWithFormat:@"%d",([self.view.blackNum.text intValue] + 1)];
               [self.MainService accumulateOnce:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_block_num"]];
               [self.navigationController popViewControllerAnimated:YES];
           };
           [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:condition onCompletion:RPCMainHandler];
           
       };
       
       [self RPCUseClass:@"Block" callMethodName:@"createBlock" withParameters:condition onCompletion:completionHandler];
   }
    
}

-(void)loadData {
    
}

#pragma mark 协议，返回轮播图片
- (NSArray *) arrayWithImages
{
    return self.photoArray;
}

//返回图片模式
- (UIViewContentMode) contentModeForImage:(NSUInteger)image
{
    return UIViewContentModeScaleAspectFill;
}

//默认图片
- (UIImage *) placeHolderImageForImagePager{
    return [UIImage imageNamed:@"no_picture"];
}

- (void)removeInfo{
    [self.MainService.promptAlert dismissWithClickedButtonIndex:0 animated:YES];
}


#pragma UIScrollView
//滚动图片
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (self.view.contactView.tag==1) {
//        self.view.phoneView.hidden = NO;
//    }else{
//        if (self.view.linearLayoutView.contentOffset.y >= 180) {
//            self.view.phoneView.hidden = NO;
//        }else {
//            self.view.phoneView.hidden = YES;
//        }
//    }
    if (self.view.contactView.tag == 1) {
        if (self.view.linearLayoutView.contentOffset.y >= 0) {
            self.view.phoneView.hidden = NO;
        }else {
            self.view.phoneView.hidden = YES;
        }

    }else{
    if (self.view.linearLayoutView.contentOffset.y >= 180) {
       self.view.phoneView.hidden = NO;
       }else {
       self.view.phoneView.hidden = YES;
       }
    }
    
}

#pragma mark 拨打电话
/**
 *  拨打电话，模拟器无法测试（待测试）
 *
 *  @param phoneNumber 电话号码
 */
-(void)callPhone:(NSString *)phoneNumber{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}

#pragma mark 类方法，计算某个经纬度点到定位点得距离
+(double)distanceBetweenOrderBy:(double)lat :(double)lng{
    
    NSDictionary *home = [MainService getHome];
    double latitude=[[home objectForKey:@"latitude"] doubleValue];
    double longitude=[[home objectForKey:@"longitude"] doubleValue];
    
    double dd = M_PI/180;
    double x1=lat*dd,x2=latitude*dd;
    double y1=lng*dd,y2=longitude*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    
    return   distance;
    
}
@end
