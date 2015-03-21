//
//  RentInfoViewController.m
//  weChat
//
//  Created by apple on 14-9-1.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "RentInfoViewController.h"
#import "RentInfoModel.h"
#import "StarView.h"

@interface RentInfoViewController ()
{
    RentInfoModel* rentInfo;
}
@end

@implementation RentInfoViewController

- (void)loadView{
    self.view = [[RentInfo alloc] init];
    self.typeId = @"2";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"出租详情"];
    
}

-(void) loadData{
    NSDictionary *NSDparameters = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",self.showId,@"id",nil];
    
    
    DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){
           
            [self.photoArray removeAllObjects];
            
            rentInfo = [[RentInfoModel alloc] initWithDictionary:[methodResult objectForKey:@"result"] error:NULL];
            if ([rentInfo.pic_url count] != 0) {
                [self.photoArray addObjectsFromArray:rentInfo.pic_url];
            }else{
                
               [self.photoArray addObject:[MainService getHouseImage:rentInfo.house_type]];
            }
            
            [self.view.imagePager reloadData];
            //初始化公共的数据
            self.phoneNumber = rentInfo.phone;
            self.view.name.text =rentInfo.name;
            self.view.phone.text =rentInfo.phone;
            
            self.view.nameCopy.text =rentInfo.name;
            self.view.phoneCopy.text =rentInfo.phone;
            
            self.view.time.text =rentInfo.publish_time;
            self.view.timeCopy.text =rentInfo.publish_time;
            
            self.view.title.text =rentInfo.page_title;
            self.view.locationLabel.text =rentInfo.address;
            
            self.view.describe.text =rentInfo.discribe;
            //设置自适应，太麻烦了，不弄了
//            [self.view.describe setNumberOfLines:0];
//            
//            self.view.describe.text = rentInfo.discribe;
//            CGSize labelsize = [self.view.describe.text sizeWithFont:self.view.describe.font constrainedToSize:CGSizeMake(self.view.describe.frame.size.width,2000) lineBreakMode:UILineBreakModeWordWrap];
            
            //计算点击
            int clickInt = [rentInfo.click_num intValue] + [self.MainService accumulateOnce:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"click_num"]];
            NSString *clickNum = [NSString stringWithFormat:@"%d",clickInt];
            self.view.visitNum.text = clickNum;
            
            //这里取消收藏我还加了一，所以除以二
            int collectCacheNum =[self.MainService getAccumulateNum:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_collect_num"]];
            int collectInt = [rentInfo.collect_num intValue] + (collectCacheNum - [rentInfo.isCollect intValue]+ 1)/2;
            NSString *collectNum = [NSString stringWithFormat:@"%d",collectInt];
            self.view.collectNum.text =collectNum;
            
            int callInt = [rentInfo.call_num intValue] + [self.MainService getAccumulateNum:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_call_num"]];
            NSString *callNum = [NSString stringWithFormat:@"%d",callInt];
            self.view.callNum.text =callNum;
            
            int blacktInt = [rentInfo.block_num intValue] + [self.MainService getAccumulateNum:[MainService getAIDEWithTableId:self.typeId rowId:self.showId field:@"d_block_num"]];
            NSString *blackNum = [NSString stringWithFormat:@"%d",blacktInt];
            self.view.blackNum.text =blackNum;
            
            UIView *startView = [[StarView alloc] initWithTrustRate:rentInfo.trust_degree];
            startView.frame = CGRectMake([UIView globalWidth]-170, -5.0, 150, 20);
            [self.view.validTitleView addSubview:startView];
            //初始化私有数据
            self.view.publishType.text =rentInfo.contact_type;
            self.view.expectMoney.text = rentInfo.rent;
            self.view.payType.text =rentInfo.payment;
            self.view.rentType.text =rentInfo.rent_type;
            self.view.area.text =rentInfo.area;
            self.view.decorate.text =rentInfo.decorate;
            self.view.base.text =rentInfo.base;
            self.view.roomType.text =rentInfo.house_type;
            self.view.direction.text =rentInfo.direction;
            self.view.floor.text =rentInfo.floor;
            self.view.houseType.text =rentInfo.house;
            
            self.HousePoint = [[BMKPointAnnotation alloc] init];
            [self.HousePoint setCoordinate:CLLocationCoordinate2DMake(rentInfo.latitude, rentInfo.longitude)];
  
            
            //计算距离
            double latitude = (double)rentInfo.latitude;
            double longitude = (double)rentInfo.longitude;
            NSString *distance = [[NSString alloc]initWithFormat:@"%.f m",[GlobalInfoViewController distanceBetweenOrderBy:latitude :longitude]];
            self.view.distanceLabel.text=distance;
            
            if([rentInfo.isCollect intValue] - collectCacheNum%2!=0){
                self.followId = rentInfo.collectId;
                self.navigationItem.rightBarButtonItem=self.collectedButton;
            }else{
                self.navigationItem.rightBarButtonItem=self.collectButton;
            }
            
        };
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
        
        [self.loadingView removeFromSuperview];
    };
    [self RPCUseClass:@"RentResources" callMethodName:@"getSingleInfo" withParameters:NSDparameters onCompletion:completionHandler];
  
    
}




@end
