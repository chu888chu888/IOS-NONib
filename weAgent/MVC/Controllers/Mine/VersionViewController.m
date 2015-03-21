//
//  VersionViewController.m
//  weAgent
//
//  Created by apple on 14-10-24.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "VersionViewController.h"


@interface VersionViewController ()

@end

@implementation VersionViewController
-(void)loadView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.view = tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"关于"];
    self.view.bounces = NO;
//    [self addBackButton];
    
    UIView *copyRightView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-124, CGRectGetWidth(self.view.bounds), 50)];
    UILabel *softNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), 30)];
    softNameLable.text = @"微中介";
    softNameLable.textAlignment = NSTextAlignmentCenter;
    softNameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    softNameLable.textColor = [UIColor lightGrayColor];
    [copyRightView addSubview:softNameLable];
    
    UILabel *copyRightLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 30.0, CGRectGetWidth(self.view.bounds), 20)];
    copyRightLable.text = @"©2014-2016 818fang.com All rights reserved.";
    copyRightLable.textAlignment = NSTextAlignmentCenter;
    copyRightLable.font = [UIFont fontWithName:@"Helvetica" size:10];
    copyRightLable.textColor = [UIColor lightGrayColor];
    [copyRightView addSubview:copyRightLable];
    
    [self.view addSubview:copyRightView];


    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.view deselectRowAtIndexPath:[self.view indexPathForSelectedRow] animated:YES];
}

- (void)update{
    
    //发出同步请求，获取商店中的版本相关信息
    NSString *appleID = @"5211486@qq.com";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appleID]]];
    
    [request setHTTPMethod:@"GET"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *releaseInfo = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:nil];
    
    NSString *latestVersion = [releaseInfo objectForKey:@"version"];
    NSString *trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
    
    //获取当前的版本信息
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    
    double doubleLatestVersion = [latestVersion doubleValue];
    double doubleCurrentVersion = [currentVersion doubleValue];
    NSLog(@"last : %f _______ current : %f",doubleLatestVersion,doubleCurrentVersion);
    if (doubleCurrentVersion<doubleLatestVersion) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"消息" message:@"您已经是最新版本，感谢您的支持！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    
    
    
    

//    ForRentCustomerTableViewController *forRentTVC = [[ForRentCustomerTableViewController alloc] init];
//    GlobalNavigationViewController *forRentNVC = [[GlobalNavigationViewController alloc] initWithRootViewController:forRentTVC];
//    [self presentViewController:forRentNVC animated:YES completion:^{}];
    
}


- (void)softInfo{
    IntroduceViewController *introduceVC = [[IntroduceViewController alloc] init];
    introduceVC.toNextViewDetegate = self;
    [self presentViewController:introduceVC animated:YES completion:^{}];
}

- (void)versionInfo{

    VersionInfoViewController *versionInfoVC = [[VersionInfoViewController alloc]init];
    [self.navigationController pushViewController:versionInfoVC animated:YES];
    
}

- (void)feedback{
   
    FeedbackViewController *feedbackVC = [[FeedbackViewController alloc]init];
    [self.navigationController pushViewController:feedbackVC animated:YES];
    
}

- (void)toNextView
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *logo = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), 160)];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2-50, 20.0, 100, 100)];
    [logoView setImage:[UIImage imageNamed:@"logo"]];
    [logo addSubview:logoView];
    
    UILabel *versionLable = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 130.0, CGRectGetWidth(self.view.bounds), 12)];
    versionLable.text = @"版本号 1.2.0";
    versionLable.textAlignment = NSTextAlignmentCenter;
    versionLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    versionLable.textColor = [UIColor lightGrayColor];
    [logo addSubview:versionLable];

    return logo;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 160;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//
//    return 1.0;
//
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
    static NSString *CellIdentifier = @"versionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (section) {
                
            case 0:
                if(row == 0)
                {
                    cell.textLabel.text =  @"检测更新";
                   
                }
                
                if(row == 1)
                {
                    cell.textLabel.text =  @"版本说明";
                    
                }
                if(row == 2){
                    cell.textLabel.text =  @"软件说明";
                   
                }
                if(row == 3){
                    cell.textLabel.text =  @"反馈";
                    
                }

                
                break;
                
                
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = (int)indexPath.row;
    int section = (int)indexPath.section;
    
    
    
    switch (section) {
        case 0:
            if(row == 0)
            {
                [self update];
                
            }
            if(row == 1)
            {
                [self versionInfo];
                
            }
            if(row == 2){
                [self softInfo];
                
            }
            if(row == 3){
                [self feedback];
                
            }
            break;
        default:
            break;
    }
    
    
}

@end
