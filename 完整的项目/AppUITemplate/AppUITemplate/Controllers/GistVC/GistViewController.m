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
    //[self setHidesBottomBarWhenPushed:YES];
    // Do any additional setup after loading the view.
    GistDataSourceCompletionBlock completionBlock=^(NSArray * data,NSString *errorString)
    {
        if (data!=nil) {
            [self processData:data];
        }
        else
        {
            NSLog(@"网络错误");
        }
    };
    GistDataSource *source=[GistDataSource discoverSource];
    [source getGistList:nil completion:completionBlock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Fetched Data Processing

- (void)processData:(NSMutableArray*)data
{
    if ([data count] == 0)
    {
        NSLog(@"没有读取到内容,请重试");
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
