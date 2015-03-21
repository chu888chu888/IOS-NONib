//
//  WeVisitRecommendViewController.m
//  weAgent
//
//  Created by 王拓 on 14/11/27.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "WeVisitRecommendViewController.h"
#import "RecommendCell.h"
#import "WeVisitDetailViewController.h"


@interface WeVisitRecommendViewController ()

@property (nonatomic) int counts;
@property (strong,nonatomic) NSMutableArray * WeVisitData;
@property (strong,nonatomic) NSString *CellIdentifier;

@end

@implementation WeVisitRecommendViewController

-(id)init{
    
    self = [super init];
    if(nil!=self){
        _counts=0;
        _CellIdentifier=@"forRecommendCell";
    }
    return self;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    //初始化View
    self.view = [[WeVisitRecommend alloc]init];
    self.view.listView.dataSource = self;
    self.view.listView.delegate = self;
    
    //初始化数组
    _WeVisitData = [NSMutableArray array];
    
    [self.view.listView registerClass:[RecommendCell class] forCellReuseIdentifier:self.CellIdentifier];
    
   
    [self.view.listView addHeaderWithTarget:self action:@selector(WeVisitHeaderRefreshing)];
    [self.view.listView addFooterWithTarget:self action:@selector(WeVisitFooterRefreshing)];
     [self.view.listView headerBeginRefreshing];
}


-(void) viewWillAppear:(BOOL)animated{

    if ([_WeVisitData count] == 0 && ([[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] != nil && ![[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] isEqualToString:@""])) {
        [self.view.listView headerBeginRefreshing];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  获取微访谈数据
 *
 *  @param number 获取数量
 *  @param who    表示头部或尾部
 */
- (void)getWeVisitData:(int)number to:(NSString *)who{
    
    //初始化起始位置及长度
    NSString *start=[NSString stringWithFormat:@"%i",_counts];
    NSString *length=[NSString stringWithFormat:@"%i",number];
    
    //初始化查询条件
    NSDictionary *condition = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",start,@"start",length,@"length",@"default",@"order",nil];
    
    //查询后回调操作
    DSJSONRPCCompletionHandler interviewCompletionHandler=^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            if ([[methodResult objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
                
                //将新数据加入数组
                [self.WeVisitData addObjectsFromArray:[methodResult objectForKey:@"result"]];
                
                //添加计数
                _counts = _counts+(int)[[methodResult objectForKey:@"result"] count];
            }
        };
        
        
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:condition onCompletion:RPCMainHandler];
        
        
        //reloadData重新加载表视图
        [self.view.listView reloadData];
        
        //判断正在执行的刷新类型，并结束刷新操作
        if ([who  isEqual: @"header"]) {
            [self.view.listView headerEndRefreshing];
        }
        
        if ([who  isEqual: @"footer"]) {
            [self.view.listView footerEndRefreshing];
        }
        
    };
    
    //调用查询方法
    [self RPCUseClass:@"ItvArticles" callMethodName:@"index" withParameters:condition onCompletion:interviewCompletionHandler];
    
}


/**
 *  上拉刷新
 *
 *  wangtuo
 */
-(void)WeVisitHeaderRefreshing{
    
    //重新为计数变量赋值
    _counts=0;
    //删除原来的数据
    [self.WeVisitData removeAllObjects];
    //刷新表视图
    [self.view.listView reloadData];
    //获取6条数据
    [self getWeVisitData:6 to:@"header"];
    
}


/**
 *  下拉刷新
 *
 *  wangtuo
 */
-(void)WeVisitFooterRefreshing{
    
    //获取下6条数据
    [self getWeVisitData:6 to:@"footer"];
    
}


/**
 *  设置表视图行数
 *
 *  @param tableView
 *  @param section
 *
 *  @return 返回行数
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_WeVisitData count];
}


/**
 *  设置表视图每行内容
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return 返回TableViewCell
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //创建cell
    RecommendCell *cell = (RecommendCell *)[tableView dequeueReusableCellWithIdentifier:self.CellIdentifier];
    
    //为cell中的相关属性赋值
    cell.title.text = [_WeVisitData[indexPath.row] objectForKey:@"title"];
    cell.content.text = [_WeVisitData[indexPath.row] objectForKey:@"abstract"];
    cell.counts.text= [[NSString alloc]initWithFormat:@"阅读 %@ 次",[_WeVisitData[indexPath.row] objectForKey:@"click"]];
    [cell.image setImageWithURL:[NSURL URLWithString:[_WeVisitData[indexPath.row] objectForKey:@"featuredImg"]] placeholderImage:[UIImage imageNamed:@"default_bg_ square"]];
    //设置选中后无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


/**
 *  选中后操作
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WeVisitDetailViewController *WeVisitDetailVC = [[WeVisitDetailViewController alloc]initWithId:[_WeVisitData[indexPath.row] objectForKey:@"id"]];
    WeVisitDetailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:WeVisitDetailVC animated:YES];
    
}

@end
