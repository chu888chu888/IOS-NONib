//
//  SecondFiltrateViewController.h
//  weAgent
//
//  Created by 王拓 on 14/12/10.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalViewController.h"
#import "HouseFiltrate.h"
@protocol  FiltrateDelegate<NSObject>
@required
-(void)beginFiltrate;
@end

@interface SecondFiltrateViewController : GlobalViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) id <FiltrateDelegate> filtrateDelegate;
@property (nonatomic) HouseFiltrate *view;
@property (nonatomic) NSString* rentType;
@property (nonatomic) UITextField *areaMinText;
@property (nonatomic) UITextField *areaMaxText;
@property (nonatomic) UITextField *distanceMinText;
@property (nonatomic) UITextField *distanceMaxText;

@end
