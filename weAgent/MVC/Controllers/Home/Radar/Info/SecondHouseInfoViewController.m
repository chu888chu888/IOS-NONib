//
//  RentInfoViewController.m
//  weChat
//
//  Created by apple on 14-9-1.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "SecondHouseInfoViewController.h"
#import "SecondInfoModel.h"
#import "StarView.h"

@interface SecondHouseInfoViewController (){
    SecondInfoModel* secondInfo;
}

@end


@implementation SecondHouseInfoViewController


- (void)loadView{
    self.view = [[SecondHouseInfo alloc] init];
    
    self.typeId = @"3";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"二手房详情"];
}

-(void) loadData{
    NSDictionary *NSDparameters = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",self.showId,@"id",nil];
    
    DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){

            
            [self.photoArray removeAllObjects];
            secondInfo = [[SecondInfoModel alloc] initWithDictionary:[methodResult objectForKey:@"result"] error:NULL];
            
            //公共
            self.phoneNumber = secondInfo.phone;
            [self.view.name setText:secondInfo.name];
            [self.view.phone setText:secondInfo.phone];
            self.view.nameCopy.text =secondInfo.name;
            self.view.phoneCopy.text =secondInfo.phone;
            self.view.time.text =secondInfo.publish_time;
            self.view.timeCopy.text =secondInfo.publish_time;
            self.view.title.text =secondInfo.page_title;
            self.view.locationLabel.text =secondInfo.address;
            self.view.describe.text =secondInfo.discribe;
            
            //计算点击
            int clickInt = [secondInfo.click_num intValue] + [self.MainService accumulateOnce:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"click_num"]];
            NSString *clickNum = [NSString stringWithFormat:@"%d",clickInt];
            self.view.visitNum.text = clickNum;
        
            
            int collectCacheNum =[self.MainService getAccumulateNum:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_collect_num"]];
            int collectInt = [secondInfo.collect_num intValue] + (collectCacheNum - [secondInfo.isCollect intValue]+ 1)/2;
            NSString *collectNum = [NSString stringWithFormat:@"%d",collectInt];
            self.view.collectNum.text =collectNum;
            
            
            int callInt = [secondInfo.call_num intValue] + [self.MainService getAccumulateNum:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_call_num"]];
            NSString *callNum = [NSString stringWithFormat:@"%d",callInt];
            self.view.callNum.text =callNum;
            
            int blacktInt = [secondInfo.block_num intValue] + [self.MainService getAccumulateNum:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_block_num"]];
            NSString *blackNum = [NSString stringWithFormat:@"%d",blacktInt];
            self.view.blackNum.text =blackNum;
            
            UIView *startView = [[StarView alloc] initWithTrustRate:secondInfo.trust_degree];        startView.frame = CGRectMake([UIView globalWidth]-170, -5.0, 150, 20);
            [self.view.validTitleView addSubview:startView];
            
            
            //私有
            self.view.publishType.text =secondInfo.contact_type;
            self.view.expectMoney.text =secondInfo.price;
            self.view.area.text =secondInfo.area;
            self.view.decorate.text =secondInfo.decorate;
            self.view.base.text =secondInfo.base;
            self.view.roomType.text =secondInfo.house_type;
            self.view.direction.text =secondInfo.direction;
            self.view.floor.text =secondInfo.floor;
            self.view.houseType.text =secondInfo.house;
            
            self.HousePoint = [[BMKPointAnnotation alloc] init];
            [self.HousePoint setCoordinate:CLLocationCoordinate2DMake(secondInfo.latitude, secondInfo.longitude)];
            
            //计算距离
            double latitude = (double)secondInfo.latitude;
            double longitude = (double)secondInfo.longitude;
            NSString *distance = [[NSString alloc]initWithFormat:@"%.f m",[GlobalInfoViewController distanceBetweenOrderBy:latitude :longitude]];
            self.view.distanceLabel.text=distance;
       
      
            if ([secondInfo.pic_url count] != 0) {
                [self.photoArray addObjectsFromArray:secondInfo.pic_url];
            }else{
               [self.photoArray addObject:[MainService getHouseImage:secondInfo.house_type]];
            }
            
            [self.view.imagePager reloadData];
            
            if([secondInfo.isCollect intValue] - collectCacheNum%2!=0){
                self.followId = secondInfo.collectId;
                self.navigationItem.rightBarButtonItem=self.collectedButton;
            }else{
                self.navigationItem.rightBarButtonItem=self.collectButton;
                
            }
            
        };
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
        
        [self.loadingView removeFromSuperview];
        
    };
    [self RPCUseClass:@"SecondHouses" callMethodName:@"getSingleInfo" withParameters:NSDparameters onCompletion:completionHandler];
}


@end
