//
//  RentTableViewController.h
//  weChat
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "RentCustomerTableViewController.h"
#import "RentInfoViewController.h"
#import "HouseListCell.h"
#import "RentCustomModel.h"
#import "StarView.h"


@interface RentCustomerTableViewController ()

@property (strong, nonatomic) NSMutableArray *rentData;
@property (strong, nonatomic) NSString *listTableViewCellIdentifier;

@end

@implementation RentCustomerTableViewController
#pragma mark - 初始化
/**
 *  数据的懒加载
 */
static int count;

-(id)init{
    self = [super init];
    if(nil!=self){
        count=0;
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

-(void)loadView{
    self.view = [[UITableView alloc] init];
    self.view.dataSource = self;
    self.view.delegate = self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self setTitle:@"出租房"];
    
    
    // 1.注册cell marenqing 性特性ios6
    [self.view registerClass:[HouseListCell class] forCellReuseIdentifier:self.listTableViewCellIdentifier ];
    self.view.rowHeight = 66;
    
    // 2.集成刷新控件
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.view addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [self.view headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.view addFooterWithTarget:self action:@selector(footerRereshing)];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.view deselectRowAtIndexPath:[self.view indexPathForSelectedRow] animated:YES];
}



#pragma mark 开始进入刷新状态

-(void)getData:(int)number to:(NSString*)who
{
    int start = count;
    int length = number;
    
    
    NSDictionary *limit = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", start],@"start",[NSString stringWithFormat:@"%d", length],@"length",nil];
    
    
    NSDictionary *NSDparameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",limit,@"limit",@"0",@"moneyRange",nil];
    
    
    
    DSJSONRPCCompletionHandler rentCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            if ([[methodResult objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
                [self.rentData addObjectsFromArray:[methodResult objectForKey:@"result"]];
                count = count+length;
                [self.view reloadData];
                
            }
        };
        
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
        
        if ([who  isEqual: @"header"]) {
            [self.view headerEndRefreshing];
        }
        
        if ([who  isEqual: @"footer"]) {
            [self.view footerEndRefreshing];
        }
        
        
        
    };
    
    [self RPCUseClass:@"Follow" callMethodName:@"getRentResourcesFollowPage" withParameters:NSDparameters onCompletion:rentCompletionHandler];
}

- (void)headerRereshing
{
    count=0;
    [self.rentData removeAllObjects];
    //这句话非常重要
    [self.view reloadData];
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
    HouseListCell *cell = (HouseListCell *)[tableView dequeueReusableCellWithIdentifier:self.listTableViewCellIdentifier];
    
     RentCustomModel *rentCustom = [[RentCustomModel alloc] initWithDictionary:_rentData[indexPath.row] error:NULL];
    
    cell.nameValue.text = rentCustom.rentResources.name;
    cell.phoneValue.text = rentCustom.rentResources.phone;
    cell.moneyLab.text = [rentCustom.rentResources.rent stringByAppendingString:@"元"];
    
    cell.typeLab.text = rentCustom.rentResources.rent_type;
    cell.distanceLab.text = [rentCustom.rentResources.area stringByAppendingString:@"㎡"];
    cell.timeLab.text = [MainService becomeDiffTime:rentCustom.rentResources.publish_time];
    
    //增加可用度
    float trustDegree = rentCustom.rentResources.trust_degree;
    StarView *starsView = [[StarView alloc] initWithTrustRate:trustDegree];
    NSArray *views = [cell.starView subviews];
    for(UIView* view in views)
    {
        [view removeFromSuperview];
    }
    [cell.starView addSubview:starsView];
    

    if (![rentCustom.rentResources.pic_url isEqualToString:@""]) {
        [cell.imageValue setImageWithURL:[NSURL URLWithString:rentCustom.rentResources.pic_url] placeholderImage:[UIImage imageNamed:@"default_bg_ square"]];
    }else{
        [cell.imageValue setImage:[MainService getHouseImage:rentCustom.rentResources.house_type]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *NSDparameters = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",[_rentData[indexPath.row] objectForKey:@"id"],@"id",nil];
        
        DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {

            RPCMainHandler RPCMainHandler= ^(id methodResult){
                if ([[methodResult objectForKey:@"code"] isEqualToString:@"070800"]) {
                    [self.rentData removeObjectAtIndex:[indexPath row]];
                    [self.view deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
                    //清空缓存
                    [self.MainService deleteCacheWithRequestIdentification:@"Follow,getRentResourcesFollowPage"];
                }else{
                    
                    self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"取消收藏失败!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [self.MainService.promptAlert show];
                    
                }
            };
            [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];

            
        };
        
        [self RPCUseClass:@"Follow" callMethodName:@"deleteFollow" withParameters:NSDparameters onCompletion:completionHandler];  
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RentInfoViewController *rentInfoVC = [[RentInfoViewController alloc] initWithId:[_rentData[indexPath.row] objectForKey:@"wanted_id"]];
    
    [self.navigationController pushViewController:rentInfoVC animated:YES];
}
@end
