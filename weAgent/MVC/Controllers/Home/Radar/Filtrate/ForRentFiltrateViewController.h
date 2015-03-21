//
//  ForRentFiltrateViewController.h
//  weAgent
//
//  Created by 王拓 on 14/12/8.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "GlobalViewController.h"
#import "HouseFiltrate.h"
@protocol  FiltrateDelegate<NSObject>
@required
-(void)beginFiltrate;
@end

@interface ForRentFiltrateViewController : GlobalViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) id <FiltrateDelegate> filtrateDelegate;
@property (nonatomic) HouseFiltrate *view;
@property (nonatomic) NSString* rentType;
@property (nonatomic) UITextField *moneyMinText;
@property (nonatomic) UITextField *moneyMaxText;
@property (nonatomic) UITextField *distanceMinText;
@property (nonatomic) UITextField *distanceMaxText;
@end
