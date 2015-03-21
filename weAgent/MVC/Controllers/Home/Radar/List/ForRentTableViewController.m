//
//  RentTableViewController.h
//  weChat
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "ForRentTableViewController.h"
#import "ForRentInfoViewController.h"
#import "SurnameView.h"
#import "WantedListModel.h"
#import "ForRentCell.h"
#import "StarView.h"


@interface ForRentTableViewController ()

@property (strong, nonatomic) NSMutableArray *rentData;
@property (strong, nonatomic) NSString *listTableViewCellIdentifier;
@property (strong, nonatomic) NSString *order;
@property (nonatomic) ForRentFiltrateViewController *HouseFiltrate;
@property (strong, nonatomic) NSMutableDictionary *filtrate;

@end

@implementation ForRentTableViewController

#pragma mark - 初始化
static int count;

-(id)init{
    self = [super init];
    if(nil!=self){
        count=0;
        _order = @"";
        self.listTableViewCellIdentifier = @"forRentCell";
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


-(void)loadView{
    self.view = [[RadarList alloc] init];
    self.view.listView.dataSource = self;
    self.view.listView.delegate = self;
    
    //注册按钮点击事件
    [self.view.timeSortBtn addTarget:self action:@selector(timeSortHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.trustSortBtn addTarget:self action:@selector(trustSortHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view.pickBtn addTarget:self action:@selector(pickHandle) forControlEvents:UIControlEventTouchUpInside];
    
    _HouseFiltrate = [[ForRentFiltrateViewController alloc] init];
    _HouseFiltrate.filtrateDelegate = self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self setTitle:@"求租信息"];
    
    
    [self.view.listView registerClass:[ForRentCell class] forCellReuseIdentifier:self.listTableViewCellIdentifier ];
    [self.view.listView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //自动刷新(一进入程序就下拉刷新)
    [self.view.listView headerBeginRefreshing];
    
    [self.view.listView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.view.listView deselectRowAtIndexPath:[self.view.listView indexPathForSelectedRow] animated:YES];
}

/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    //    NSLog(@"MJTableViewController--dealloc---");
}



- (void)beginFiltrate {
    
    //获取价格范围
    NSDictionary *moneyRange = [NSDictionary dictionaryWithObjectsAndKeys:self.HouseFiltrate.moneyMinText.text,@"minMoney",self.HouseFiltrate.moneyMaxText.text,@"maxMoney",nil];
    
    //初始化筛选条件
    _filtrate = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.HouseFiltrate.rentType,@"houseType",moneyRange,@"moneyRange",nil];
    
    //刷新页面
    [self.view.listView headerBeginRefreshing];
    
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    count=0;
    //self.rentData =[[NSMutableArray alloc] init];
    [self.rentData removeAllObjects];
    //这句话非常重要
    [self.view.listView reloadData];
    
    [self getData:10 to:@"header"];
    
}

- (void)footerRereshing
{
    [self getData:10 to:@"footer"];
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


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //根据数据条数返回表视图行数
    return self.rentData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化Cell
    ForRentCell *cell = (ForRentCell *)[tableView dequeueReusableCellWithIdentifier:self.listTableViewCellIdentifier];
    
    WantedListModel *WantedList = [[WantedListModel alloc] initWithDictionary:_rentData[indexPath.row] error:NULL];
    
    cell.nameValue.text = WantedList.name;
    cell.phoneValue.text = WantedList.phone;
    cell.moneyLab.text = [WantedList.rent stringByAppendingString:@""];
    cell.addressLab.text = WantedList.address;
    cell.timeLab.text = [MainService becomeDiffTime:WantedList.publish_time];
    
    //增加可用度
    float trustDegree = WantedList.trust_degree;
    StarView *starsView = [[StarView alloc] initWithTrustRate:trustDegree];
    NSArray *views = [cell.starView subviews];
    for(UIView* view in views)
    {
        [view removeFromSuperview];
    }
    [cell.starView addSubview:starsView];
    
    NSString *surnameString= [WantedList.name substringToIndex:1];
    
    //生成姓得图片
    SurnameView *Surname = [[SurnameView alloc] initWithSurname:surnameString];
    UIImage *SurnameImg = [self getImageFromView:Surname];
    
    [cell.imageValue setImage:SurnameImg];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForRentInfoViewController *rentInfoVC = [[ForRentInfoViewController alloc] initWithId:[_rentData[indexPath.row] objectForKey:@"id"]];
    
    [self.navigationController pushViewController:rentInfoVC animated:YES];
}


/**
 *  获取数据
 *
 *  @param number 获取条数
 *  @param who    顶部或是底部刷新
 */
-(void)getData:(int)number to:(NSString*)who
{
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
    
    [self RPCUseClass:@"Wanted" callMethodName:@"getRequestPageSources" withParameters:NSDparameters onCompletion:rentCompletionHandler];
}

@end
