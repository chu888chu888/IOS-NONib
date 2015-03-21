//
//  RentTableViewController.h
//  weChat
//
//  Created by apple on 14-9-2.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "SecondCustomerTableViewController.h"
#import "SecondHouseInfoViewController.h"
#import "SecondCell.h"
#import "SecondCustomModel.h"
#import "StarView.h"

@interface SecondCustomerTableViewController ()

@property (strong, nonatomic) NSMutableArray *rentData;
@property (strong, nonatomic) NSString *listTableViewCellIdentifier;

@end

@implementation SecondCustomerTableViewController
#pragma mark - 初始化
/**
 *  数据的懒加载
 */
static int count;

-(id)init{
    self = [super init];
    if(nil!=self){
        count=0;
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

-(void)loadView{
    self.view = [[UITableView alloc] init];
    self.view.dataSource = self;
    self.view.delegate = self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self setTitle:@"二手房"];
    
    // 1.注册cell marenqing 性特性ios6
    [self.view registerClass:[SecondCell class] forCellReuseIdentifier:self.listTableViewCellIdentifier ];
    self.view.rowHeight = 66;
    
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
    
    [self RPCUseClass:@"Follow" callMethodName:@"getSecondFollowPage" withParameters:NSDparameters onCompletion:rentCompletionHandler];
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
    SecondCell *cell = (SecondCell *)[tableView dequeueReusableCellWithIdentifier:self.listTableViewCellIdentifier];
    
    SecondCustomModel *secondCustom = [[SecondCustomModel alloc] initWithDictionary:_rentData[indexPath.row] error:NULL];
    
    cell.nameValue.text = secondCustom.secondHouses.name;
    cell.phoneValue.text = secondCustom.secondHouses.phone;
    cell.moneyLab.text = [[NSString alloc] initWithFormat:@"%@万元", secondCustom.secondHouses.price];
    cell.addressLab.text =[[NSString alloc]initWithFormat:@"%@㎡",secondCustom.secondHouses.area];
    cell.housetypeLab.text = secondCustom.secondHouses.house_type;
    
    cell.timeLab.text = [MainService becomeDiffTime:secondCustom.secondHouses.publish_time];
    
    //增加可用度
    float trustDegree = secondCustom.secondHouses.trust_degree;
    StarView *starsView = [[StarView alloc] initWithTrustRate:trustDegree];
    NSArray *views = [cell.starView subviews];
    for(UIView* view in views)
    {
        [view removeFromSuperview];
    }
    [cell.starView addSubview:starsView];
    
    //异步加载图片
    if (![secondCustom.secondHouses.pic_url isEqualToString:@""]) {
        [cell.imageValue setImageWithURL:[NSURL URLWithString:secondCustom.secondHouses.pic_url] placeholderImage:[UIImage imageNamed:@"default_bg_ square"]];
    }else{
        [cell.imageValue setImage:[MainService getHouseImage:secondCustom.secondHouses.house_type]];
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
                    [self.MainService deleteCacheWithRequestIdentification:@"Follow,getSecondFollowPage"];
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
    SecondHouseInfoViewController *rentInfoVC = [[SecondHouseInfoViewController alloc] initWithId:[_rentData[indexPath.row] objectForKey:@"wanted_id"]];
    [self.navigationController pushViewController:rentInfoVC animated:YES];
}
@end
