//
//  WeVisitPassViewController.m
//  weAgent
//
//  Created by 王拓 on 14/11/27.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "WeVisitPassViewController.h"
#import "PassCell.h"
#import "WeVisitDetailViewController.h"

@interface WeVisitPassViewController ()
@property (nonatomic) int counts;
@property (strong,nonatomic) NSMutableArray * WeVisitDataPass;
@property (strong,nonatomic) NSString *CellIdentifier;
@end

@implementation WeVisitPassViewController

-(id)init{
    
    self = [super init];
    if(nil!=self){
        _counts=0;
        _CellIdentifier=@"forPassCell";
    }
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[WeVisitPass alloc]init];
    self.view.listView.dataSource = self;
    self.view.listView.delegate = self;
    
    //初始化tableCell
    [self.view.listView registerClass:[PassCell class] forCellReuseIdentifier:self.CellIdentifier];
    //初始化存放数据的数组
    _WeVisitDataPass = [NSMutableArray array];
    
    
    //注册上拉、下拉刷新事件
    [self.view.listView addHeaderWithTarget:self action:@selector(WeVisitHeaderRefreshing)];
    [self.view.listView addFooterWithTarget:self action:@selector(WeVisitFooterRefreshing)];
    
    //一开始获取6条数据
    [self.view.listView headerBeginRefreshing];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  获取微访谈数据
 *
 *  wangtuo
 *
 *  @param number 获取数量
 *  @param who    表示头部或尾部
 */
- (void)getWeVisitData:(int)number to:(NSString *)who{
    
    //初始化起始位置及长度
    NSString *start=[NSString stringWithFormat:@"%i",_counts];
    NSString *length=[NSString stringWithFormat:@"%i",number];
    
    //初始化查询条件，不需要登录拦截所以使用了一个已有的diploma
    NSDictionary *condition = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",start,@"start",length,@"length",nil];
    
    //查询后回调操作
    DSJSONRPCCompletionHandler interviewCompletionHandler=^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            if ([[methodResult objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
                //将新数据加入数组
                [self.WeVisitDataPass addObjectsFromArray:[methodResult objectForKey:@"result"]];
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
    [self.WeVisitDataPass removeAllObjects];
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
    
    //获取6条数据
    [self getWeVisitData:6 to:@"footer"];
    
}


/**
 *  设置表视图行数
 *
 *  wangtuo
 *
 *  @param tableView
 *  @param section
 *  
 *  @return 返回行数
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_WeVisitDataPass count];
}


/**
 *  设置表视图每行内容
 *
 *  wangtuo
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return 返回TableViewCell
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //初始化cell
    PassCell *cell = (PassCell *)[tableView dequeueReusableCellWithIdentifier:self.CellIdentifier];
    
    //为单元内的属性赋值
    cell.title.text = [_WeVisitDataPass[indexPath.row] objectForKey:@"title"];
    cell.subTitle.text = [_WeVisitDataPass[indexPath.row] objectForKey:@"abstract"];
    cell.counts.text = [[NSString alloc]initWithFormat:@"阅读 %@",[_WeVisitDataPass[indexPath.row] objectForKey:@"click"]];
    [cell.headImage setImageWithURL:[NSURL URLWithString:[_WeVisitDataPass[indexPath.row] objectForKey:@"img_head"]] placeholderImage:[UIImage imageNamed:@"default_bg_ square"]];
    
    //设置选中无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


/**
 *  选中后的执行动作
 *
 *  wangtuo
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WeVisitDetailViewController *WeVisitDetailVC = [[WeVisitDetailViewController alloc]initWithId:[_WeVisitDataPass[indexPath.row] objectForKey:@"id"]];
    WeVisitDetailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:WeVisitDetailVC animated:YES];
    
}


@end
