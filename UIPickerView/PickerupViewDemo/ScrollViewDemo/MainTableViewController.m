//
//  MainTableViewController.m
//  ScrollViewDemo
//
//  Created by chuguangming on 15/9/18.
//  Copyright © 2015年 chu. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 480, 180)];
    scrollView.contentSize=CGSizeMake(480*4, 180);
    scrollView.pagingEnabled=YES;
    scrollView.backgroundColor=[UIColor redColor];
    scrollView.delegate=self;
    
    self.tableView.tableHeaderView=scrollView;
    
    float _x=0;
    for (int index=1; index<5 ; index++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0+_x, 0, 480, 180)];
        NSString *imageName=[NSString stringWithFormat:@"image%d.jpg",index];
        imageView.image=[UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        _x+=480;
    }
    
    UIPageControl *pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 150, 320, 30)];
    pageControl.numberOfPages=4;
    pageControl.tag=1010;
    [self.view addSubview:pageControl];
    
    
}
#pragma mark -ScrollView Delegate
//scrollView 开始拖动
-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
}
//scrollView 结束拖动
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewEndDragging");
}
//scrollView 开始减速
-(void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDecelerating");
}
// scrollView 减速停止
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        NSLog(@"你用的是UITableView");
    }
    else
    {
        NSLog(@"你用的是ScrollView");
        NSLog(@"scrollView:%f",scrollView.contentOffset.x);
        
        int current=scrollView.contentOffset.x/480;
        UIPageControl *pageControl=(UIPageControl *)[self.view viewWithTag:1010];
        pageControl.numberOfPages=current;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text=[NSString stringWithFormat:@"row:%ld",indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
