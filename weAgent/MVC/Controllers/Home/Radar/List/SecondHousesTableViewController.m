//
//  RentTableViewController.h
//  weChat
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "SecondHousesTableViewController.h"
#import "SecondHouseInfoViewController.h"
#import "SecondCell.h"
#import "StarView.h"
#import "SecondListModel.h"


@interface SecondHousesTableViewController ()

@property (strong, nonatomic) NSMutableArray *rentData;
@property (strong, nonatomic) NSString *listTableViewCellIdentifier;

@property (strong, nonatomic) NSString *order;
@property (nonatomic) SecondFiltrateViewController *HouseFiltrate;
@property (strong, nonatomic) NSMutableDictionary *filtrate;

@end

@implementation SecondHousesTableViewController
#pragma mark - 初始化
/**
 *  数据的懒加载
 */
static int count;

-(id)init{
    self = [super init];
    if(nil!=self){
        count=0;
        _order = @"";
        self.listTableViewCellIdentifier = @"secondCell";
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

-(void)getData:(int)number to:(NSString*)who
{
    int start = count;
    int length = number;
   
    
    NSDictionary *limit = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", start],@"start",[NSString stringWithFormat:@"%d", length],@"length",nil];
    
    NSDictionary *condition = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",[MainService getHome],@"home",limit,@"limit",@"0",@"moneyRange",[[NSUserDefaults standardUserDefaults] objectForKey:@"beforeDay"],@"beforeDay",[[NSUserDefaults standardUserDefaults] objectForKey:@"distance"],@"distance",_order,@"order",_filtrate ,@"filtrate",nil];
    
    
    
    DSJSONRPCCompletionHandler rentCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        //        blockSelf->_rentBadgeView.text= [methodResult objectForKey:@"result"];
        
        if ([[methodResult objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
            [self.rentData addObjectsFromArray:[methodResult objectForKey:@"result"]];
            count = count+length;
            [self.view.listView reloadData];
        }

        if ([who  isEqual: @"header"]) {
            [self.view.listView headerEndRefreshing];
        }
        
        if ([who  isEqual: @"footer"]) {
            [self.view.listView footerEndRefreshing];
        }
        
        
        
    };
    
    [self RPCUseClass:@"SecondHouses" callMethodName:@"getRequestPageSources" withParameters:condition onCompletion:rentCompletionHandler];
}

-(void)loadView{
    self.view = [[RadarList alloc] init];
    self.view.listView.dataSource = self;
    self.view.listView.delegate = self;
    
    [self.view.listView registerClass:[SecondCell class] forCellReuseIdentifier:self.listTableViewCellIdentifier ];
    
    [self.view.timeSortBtn addTarget:self action:@selector(timeSortHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.trustSortBtn addTarget:self action:@selector(trustSortHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.pickBtn addTarget:self action:@selector(pickHandle) forControlEvents:UIControlEventTouchUpInside];
    
    _HouseFiltrate = [[SecondFiltrateViewController alloc] init];
    _HouseFiltrate.filtrateDelegate = self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self setTitle:@"二手房"];
    
    // 1.注册cell marenqing 性特性ios6
    [self.view.listView registerClass:[SecondCell class] forCellReuseIdentifier:self.listTableViewCellIdentifier ];
    
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



#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondCell *cell = (SecondCell *)[tableView dequeueReusableCellWithIdentifier:self.listTableViewCellIdentifier];
    
    SecondListModel *secondList = [[SecondListModel alloc] initWithDictionary:_rentData[indexPath.row] error:NULL];
    
    cell.nameValue.text = secondList.name;
    cell.phoneValue.text = secondList.phone;
    cell.moneyLab.text = [[NSString alloc] initWithFormat:@"%@万元", secondList.price];
    cell.addressLab.text =[[NSString alloc]initWithFormat:@"%@㎡",secondList.area];
    cell.housetypeLab.text = secondList.house_type;
    
    cell.timeLab.text = [MainService becomeDiffTime:secondList.publish_time];
    
    //增加可用度
    float trustDegree = secondList.trust_degree;
    StarView *starsView = [[StarView alloc] initWithTrustRate:trustDegree];
    NSArray *views = [cell.starView subviews];
    for(UIView* view in views)
    {
        [view removeFromSuperview];
    }
    [cell.starView addSubview:starsView];
    
    //异步加载图片
    if (![secondList.pic_url isEqualToString:@""]) {
        [cell.imageValue setImageWithURL:[NSURL URLWithString:secondList.pic_url] placeholderImage:[UIImage imageNamed:@"default_bg_ square"]];
    }else{
        [cell.imageValue setImage:[MainService getHouseImage:secondList.house_type]];
    }
    
    return cell;
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
//    NSDictionary *moneyRange = [NSDictionary dictionaryWithObjectsAndKeys:self.HouseFiltrate.areaMinText.text,@"minArea",self.HouseFiltrate.areaMaxText.text,@"maxArea",nil];
    NSDictionary *area = [NSDictionary dictionaryWithObjectsAndKeys:self.HouseFiltrate.areaMinText.text,@"minArea",self.HouseFiltrate.areaMaxText.text,@"maxArea",nil];
    
    _filtrate = [NSMutableDictionary dictionaryWithObjectsAndKeys:area,@"area",nil];
    [self.view.listView headerBeginRefreshing];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondHouseInfoViewController *rentInfoVC = [[SecondHouseInfoViewController alloc] initWithId:[_rentData[indexPath.row] objectForKey:@"id"]];
    
    
    [self.navigationController pushViewController:rentInfoVC animated:YES];
}
@end
