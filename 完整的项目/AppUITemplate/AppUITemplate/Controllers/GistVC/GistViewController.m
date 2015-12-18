//
//  GistViewController.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/16.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "GistViewController.h"
#import "GistDataSource.h"
@interface GistViewController ()
@property (nonatomic, strong) NSMutableArray* dataSource;
@end

@implementation GistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self requestGistSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Setup Methods
-(void)setupTableView
{
    
}
#pragma mark -
#pragma mark Network Request methods
-(void)requestGistSource
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        GistDataSourceCompletionBlock completionBlock=^(NSMutableArray * data,NSString *errorString)
        {
            if (data!=nil) {
                [self processData:data];
            }
            else
            {
                [UIView addMJNotifierWithText:@"网络故障请重试" dismissAutomatically:YES];
            }
        };
        GistDataSource *source=[GistDataSource discoverSource];
        [source getGistList:nil completion:completionBlock];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}
#pragma mark -
#pragma mark Fetched Data Processing

- (void)processData:(NSMutableArray*)data
{
    if ([data count] == 0)
    {
        [UIView addMJNotifierWithText:@"没有读取到内容,请重试" dismissAutomatically:YES];
    }
    else
    {
        if (!self.dataSource)
        {
            self.dataSource = [[NSMutableArray alloc] init];
        }
        self.dataSource = data;
        [self.tableView reloadData];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text =[[self.dataSource objectAtIndex:indexPath.row] url];
    return cell;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
