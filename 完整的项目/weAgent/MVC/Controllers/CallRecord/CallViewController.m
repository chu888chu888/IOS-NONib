//
//  ForRentCallViewController.m
//  weAgent
//
//  Created by apple on 14/12/18.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "CallViewController.h"
NSString *const CallRecordCellIdentifier = @"CallRecordCell";

@interface CallViewController ()
@property (strong, nonatomic) NSMutableArray *rentData;
@property (strong, nonatomic) NSString *typeId;
@property (nonatomic) int counts;
@property (strong, nonatomic) NSString *phoneNum;
@end

@implementation CallViewController

#pragma mark 初始化
-(id)initWithTypeId:(NSString*)theTypeId{
    self = [super init];
    if(nil!=self){
        _counts = 0;
        _typeId = theTypeId;
    }
    return self;
}

-(void) loadView{
    self.view = [[UITableView alloc] init];
    self.view.dataSource = self;
    self.view.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rentData = [NSMutableArray array];
    self.phoneNum =[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    // 2.集成刷新控件
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.view addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [self.view headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.view addFooterWithTarget:self action:@selector(footerRereshing)];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    
    if (![_phoneNum isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]]) {
        self.phoneNum =[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
        [self.view headerBeginRefreshing];
    }
}

#pragma mark 加载数据
-(void)getData:(int)number to:(NSString*)who
{
    
    int start = _counts;
    int length = number;
    
    NSDictionary *limit = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", start],@"start",[NSString stringWithFormat:@"%d", length],@"length",nil];
    
    NSDictionary *NSDparameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",limit,@"limit",_typeId,@"typeId",nil];
    
    
    DSJSONRPCCompletionHandler rentCompletionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
        
        RPCMainHandler RPCMainHandler= ^(id methodResult){
            if ([[methodResult objectForKey:@"result"] isKindOfClass:[NSArray class]]) {
                [self.rentData addObjectsFromArray:[methodResult objectForKey:@"result"]];
                
                self.counts = self.counts + (int)[[methodResult objectForKey:@"result"] count];
            }
            [self.view reloadData];
        };
        
        
        [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
        
        if ([who  isEqual: @"header"]) {
            [self.view headerEndRefreshing];
        }
        
        if ([who  isEqual: @"footer"]) {
            [self.view footerEndRefreshing];
        }
        
    };
    [self RPCUseClass:@"Call" callMethodName:@"getCallRecordsPage" withParameters:NSDparameters onCompletion:rentCompletionHandler];
}




#pragma mark 刷新
- (void)headerRereshing
{
    _counts=0;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CallRecordCellIdentifier];
    //    这里有性能问题
    //    if ((cell == nil)||(_isReload)) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CallRecordCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    timeLable.numberOfLines =2;
    timeLable.textAlignment = NSTextAlignmentRight;
    timeLable.text= [MainService becomeCallDiffTime:[_rentData[indexPath.row] objectForKey:@"create_at"]] ;
    
    timeLable.font =[UIFont baseWithSize:10];
    timeLable.textColor =[UIColor grayColor];
    cell.accessoryView= timeLable;
    
    if ([_typeId isEqual:@"1"]) {
        if ([[_rentData[indexPath.row] objectForKey:@"wanted"] isKindOfClass:[NSDictionary class]]) {
            cell.textLabel.text= [[_rentData[indexPath.row] objectForKey:@"wanted"] objectForKey:@"name"];
            cell.detailTextLabel.text=[[_rentData[indexPath.row] objectForKey:@"wanted"] objectForKey:@"phone"];
            
            cell.detailTextLabel.textColor = [UIColor orangeColor];
        }
        
    }
    
    if ([_typeId isEqual:@"2"]) {
        if ([[_rentData[indexPath.row] objectForKey:@"rentResources"] isKindOfClass:[NSDictionary class]]) {
            cell.textLabel.text= [[_rentData[indexPath.row] objectForKey:@"rentResources"] objectForKey:@"name"];
            
            cell.detailTextLabel.text=[[_rentData[indexPath.row] objectForKey:@"rentResources"] objectForKey:@"phone"];
            cell.detailTextLabel.textColor = [UIColor orangeColor];
            
        }
    }
    
    if ([_typeId isEqual:@"3"]) {
        if ([[_rentData[indexPath.row] objectForKey:@"secondHouses"] isKindOfClass:[NSDictionary class]]) {
            cell.textLabel.text= [[_rentData[indexPath.row] objectForKey:@"secondHouses"] objectForKey:@"name"];
            cell.detailTextLabel.text=[[_rentData[indexPath.row] objectForKey:@"secondHouses"] objectForKey:@"phone"];
            
            cell.detailTextLabel.textColor = [UIColor orangeColor];
        }
    }
    
    return cell;
}

//隐藏选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view deselectRowAtIndexPath:[self.view indexPathForSelectedRow] animated:YES];
}

#pragma mark 滑动删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *NSDparameters = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",[_rentData[indexPath.row] objectForKey:@"id"],@"id",nil];
        
        DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
            
            RPCMainHandler RPCMainHandler= ^(id methodResult){
                
                if ([[methodResult objectForKey:@"code"] isEqualToString:@"090400"]) {
                    [self.rentData removeObjectAtIndex:[indexPath row]];
                    [self.view deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
                    //清空缓存
                    [self.MainService deleteCacheWithRequestIdentification:@"Call,getCallRecordsPage"];
                    [self.MainService deleteCacheWithRequestIdentification:@"Call,getAchievements"];
                    
                }else{
                    self.MainService.promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"删除失败!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    
                    [self.MainService.promptAlert show];
                }
            };
            [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
        };
        
        [self RPCUseClass:@"Call" callMethodName:@"destory" withParameters:NSDparameters onCompletion:completionHandler];
        
    }
    
}


@end
