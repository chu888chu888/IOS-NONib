//
//  RentTableViewController.h
//  weChat
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "RentTableViewController.h"
#import "RentInfoViewController.h"
#import "RentListModel.h"
#import "HouseListCell.h"
#import "StarView.h"

@interface RentTableViewController ()

@property (strong, nonatomic) NSMutableArray *rentData;
@property (strong, nonatomic) NSString *listTableViewCellIdentifier;
@property (strong, nonatomic) NSString *order;
@property (nonatomic) HouseFiltrateViewController *HouseFiltrate;
@property (strong, nonatomic) NSMutableDictionary *filtrate;
@end

@implementation RentTableViewController
#pragma mark - 初始化
static int count;

-(id)init{
    self = [super init];
    if(nil!=self){
        count=0;
        _order = @"";
        self.listTableViewCellIdentifier = @"rentCell";
    }
    return self;    
}

- (NSMutableArray *)rentData
{
    if (!_rentData) {
        self.rentData = [NSMutableArray array];
    }
    return _rentData;
}


-(void)loadView {
    self.view = [[RadarList alloc] init];
    self.view.listView.dataSource = self;
    self.view.listView.delegate = self;
    [self.view.timeSortBtn addTarget:self action:@selector(timeSortHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.trustSortBtn addTarget:self action:@selector(trustSortHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.pickBtn addTarget:self action:@selector(pickHandle) forControlEvents:UIControlEventTouchUpInside];
    _HouseFiltrate = [[HouseFiltrateViewController alloc] init];
    _HouseFiltrate.filtrateDelegate = self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setTitle:@"出租房"];

    // 1.注册cell marenqing 性特性ios6
     [self.view.listView registerClass:[HouseListCell class] forCellReuseIdentifier:self.listTableViewCellIdentifier ];
            
    // 2.集成刷新控件
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.view.listView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [self.view.listView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.view.listView addFooterWithTarget:self action:@selector(footerRereshing)];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.view.listView deselectRowAtIndexPath:[self.view.listView indexPathForSelectedRow] animated:YES];
}
#pragma mark 筛选处理
- (void)timeSortHandle {
    _order = @"publish_time";
    [self.view.listView headerBeginRefreshing];
}

- (void)trustSortHandle {
    _order = @"trust_degree";
    [self.view.listView headerBeginRefreshing];
}

- (void)pickHandle {
    
    GlobalNavigationViewController *houseFiltrateNVC = [[GlobalNavigationViewController alloc] initWithRootViewController:_HouseFiltrate];
    [self presentViewController:houseFiltrateNVC animated:YES completion:^{}];
    
}

- (void)beginFiltrate {
     NSDictionary *moneyRange = [NSDictionary dictionaryWithObjectsAndKeys:self.HouseFiltrate.moneyMinText.text,@"minMoney",self.HouseFiltrate.moneyMaxText.text,@"maxMoney",nil];
     NSDictionary *area = [NSDictionary dictionaryWithObjectsAndKeys:self.HouseFiltrate.distanceMinText.text,@"minArea",self.HouseFiltrate.distanceMaxText.text,@"maxArea",nil];
    
     _filtrate = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.HouseFiltrate.rentType,@"houseType",moneyRange,@"moneyRange",area,@"area",nil];
    [self.view.listView headerBeginRefreshing];

}

#pragma mark 刷新处理
-(void)getData:(int)number to:(NSString*)who {
    int start = count;
    int length = number;
    
    NSDictionary *limit = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", start],@"start",[NSString stringWithFormat:@"%d", length],@"length",nil];
    
    NSDictionary *NSDparameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",[MainService getHome],@"home",limit,@"limit",@"0",@"moneyRange",[[NSUserDefaults standardUserDefaults] objectForKey:@"beforeDay"],@"beforeDay",[[NSUserDefaults standardUserDefaults] objectForKey:@"distance"],@"distance",_order,@"order",_filtrate ,@"filtrate",nil];
    
    DSJSONRPCCompletionHandler rentCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            if ([[methodResult objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
                [self.rentData addObjectsFromArray:[methodResult objectForKey:@"result"]];
                count = count+length;
                [self.view.listView reloadData];
            }
        };
        
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
        
        if ([who  isEqual: @"header"]) {
            [self.view.listView headerEndRefreshing];
        }
        if ([who  isEqual: @"footer"]) {
            [self.view.listView footerEndRefreshing];
        }
        
    };
    
    [self RPCUseClass:@"RentResources" callMethodName:@"getRequestPageSources" withParameters:NSDparameters onCompletion:rentCompletionHandler];
}


- (void)headerRereshing {
    count=0;
    //    self.rentData =[[NSMutableArray alloc] init];
    [self.rentData removeAllObjects];
    //这句话非常重要
    [self.view.listView reloadData];
    [self getData:10 to:@"header"];
}

- (void)footerRereshing
{
    [self getData:10 to:@"footer"];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HouseListCell *cell = (HouseListCell *)[tableView dequeueReusableCellWithIdentifier:self.listTableViewCellIdentifier];
    
    RentListModel *rentList = [[RentListModel alloc] initWithDictionary:_rentData[indexPath.row] error:NULL];
    
    cell.nameValue.text = rentList.name;
    cell.phoneValue.text = rentList.phone;
    cell.moneyLab.text = [rentList.rent stringByAppendingString:@"元"];
    
    cell.typeLab.text = rentList.rent_type;
    cell.distanceLab.text = [rentList.area stringByAppendingString:@"㎡"];
    cell.timeLab.text = [MainService becomeDiffTime:rentList.publish_time];
    
    //增加可用度
    float trustDegree = rentList.trust_degree;
    StarView *starsView = [[StarView alloc] initWithTrustRate:trustDegree];
    NSArray *views = [cell.starView subviews];
    for(UIView* view in views)
    {
        [view removeFromSuperview];
    }
    [cell.starView addSubview:starsView];
    
    
    if (![rentList.pic_url isEqualToString:@""]) {
        [cell.imageValue setImageWithURL:[NSURL URLWithString:rentList.pic_url] placeholderImage:[UIImage imageNamed:@"default_bg_ square"]];
    }else{
        [cell.imageValue setImage:[MainService getHouseImage:rentList.house_type]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RentInfoViewController *rentInfoVC = [[RentInfoViewController alloc] initWithId:[_rentData[indexPath.row] objectForKey:@"id"]];

   
    [self.navigationController pushViewController:rentInfoVC animated:YES];
}
@end
