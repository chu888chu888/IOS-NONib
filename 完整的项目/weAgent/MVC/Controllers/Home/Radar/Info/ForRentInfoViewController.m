//
//  RentInfoViewController.m
//  weChat
//
//  Created by apple on 14-9-1.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "ForRentInfoViewController.h"
#import "WandedInfoModel.h"
#import "StarView.h"


@interface ForRentInfoViewController ()
{
    WandedInfoModel* wantedInfo;
}
@end


@implementation ForRentInfoViewController


- (void)loadView{
    self.view = [[ForRentInfo alloc] init];
    
    self.typeId = @"1";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"求租详情"];
}

-(void) loadData{
    NSDictionary *NSDparameters = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",self.showId,@"id",nil];
    
    
    DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            [self.photoArray removeAllObjects];
            
            wantedInfo = [[WandedInfoModel alloc] initWithDictionary:[methodResult objectForKey:@"result"] error:NULL];
            

            
            [self.photoArray addObjectsFromArray:wantedInfo.pic_url];
            [self.view.imagePager reloadData];
            //初始化公共的数据
            self.phoneNumber = wantedInfo.phone;
            self.view.name.text = wantedInfo.name;
            self.view.phone.text = wantedInfo.phone;
            
            self.view.nameCopy.text = wantedInfo.name;
            self.view.phoneCopy.text = wantedInfo.phone;
            
            self.view.time.text = wantedInfo.publish_time;
            self.view.timeCopy.text = wantedInfo.publish_time;
            
            if (!(wantedInfo.page_title==nil||wantedInfo.page_title==NULL)) {
                self.view.title.text = wantedInfo.page_title;
            }
            
            self.view.locationLabel.text = wantedInfo.address;
            
            //计算点击
            int clickInt = [wantedInfo.click_num intValue] + [self.MainService accumulateOnce:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"click_num"]];
            NSString *clickNum = [NSString stringWithFormat:@"%d",clickInt];
            self.view.visitNum.text = clickNum;
            
            //这里取消收藏我还加了一，所以除以二
            int collectCacheNum =[self.MainService getAccumulateNum:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_collect_num"]];
            int collectInt = [wantedInfo.collect_num intValue] + (collectCacheNum - [wantedInfo.isCollect intValue]+ 1)/2;
            NSString *collectNum = [NSString stringWithFormat:@"%d",collectInt];
            self.view.collectNum.text =collectNum;
            
            
            int callInt = [wantedInfo.call_num intValue] + [self.MainService getAccumulateNum:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_call_num"]];
            NSString *callNum = [NSString stringWithFormat:@"%d",callInt];
            self.view.callNum.text =callNum;
            
            int blacktInt = [wantedInfo.block_num intValue] + [self.MainService getAccumulateNum:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_block_num"]];
            NSString *blackNum = [NSString stringWithFormat:@"%d",blacktInt];
            self.view.blackNum.text =blackNum;
            
            UIView *startView = [[StarView alloc] initWithTrustRate:wantedInfo.trust_degree];
            startView.frame = CGRectMake([UIView globalWidth]-170, -5.0, 150, 20);
            [self.view.validTitleView addSubview:startView];
            
            //计算距离
            double latitude = (double)wantedInfo.latitude;
            double longitude = (double)wantedInfo.longitude;
            NSString *distance = [[NSString alloc]initWithFormat:@"%.f m",[GlobalInfoViewController distanceBetweenOrderBy:latitude :longitude]];
            self.view.distanceLabel.text=distance;
            //初始化私有部分数据
            self.view.publishType.text = wantedInfo.contact_type;
            self.view.expectMoney.text = wantedInfo.rent;
            if (!(wantedInfo.excepttime==nil||wantedInfo.excepttime==NULL)) {
                self.view.expectTime.text = wantedInfo.excepttime;
            }
            
            self.view.expectHouse.text = wantedInfo.housetype;
            self.view.describe.text = wantedInfo.discribe;
            
            self.HousePoint = [[BMKPointAnnotation alloc] init];
            [self.HousePoint setCoordinate:CLLocationCoordinate2DMake(wantedInfo.latitude, wantedInfo.longitude)];
            
            
            if([wantedInfo.isCollect intValue] - collectCacheNum%2!=0){
                self.followId = wantedInfo.isCollect;
                self.navigationItem.rightBarButtonItem=self.collectedButton;
            }else{
                self.navigationItem.rightBarButtonItem=self.collectButton;
                
            }
        };
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
        
        [self.loadingView removeFromSuperview];
        
    };
    [self RPCUseClass:@"Wanted" callMethodName:@"getSingleInfo" withParameters:NSDparameters onCompletion:completionHandler];
    
}



@end
