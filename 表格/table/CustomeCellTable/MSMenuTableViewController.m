//
//  MSMenuTableViewController.m
//  CustomeCellTable
//
//  Created by chuguangming on 15/1/23.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "MSMenuTableViewController.h"
#import "MSMenuCell.h"
#import "MSMenuTableViewHeader.h"

NSString * const MSMenuCellReuseIdentifier = @"Drawer Cell";
NSString * const MSDrawerHeaderReuseIdentifier = @"Drawer Header";

typedef NS_ENUM(NSUInteger, MSMenuViewControllerTableViewSectionType) {
    MSMenuViewControllerTableViewSectionTypeOptions,
    MSMenuViewControllerTableViewSectionTypeExamples,
    MSMenuViewControllerTableViewSectionTypeAbout,
    MSMenuViewControllerTableViewSectionTypeCount
};
@interface MSMenuTableViewController ()
@property (nonatomic, strong) NSDictionary *paneViewControllerTitles;
@property (nonatomic, strong) NSDictionary *paneViewControllerClasses;
@property (nonatomic, strong) NSDictionary *sectionTitles;
@property (nonatomic, strong) NSArray *tableViewSectionBreaks;

@property (nonatomic, strong) UIBarButtonItem *paneRevealLeftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *paneRevealRightBarButtonItem;
@end

@implementation MSMenuTableViewController
@synthesize paneRevealLeftBarButtonItem,paneRevealRightBarButtonItem;
#pragma mark - UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //通过initialize来初始化数据
        [self initialize];
    }
    return self;
}

- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //通过代码自定义代码单元格与单元表头
    [self.tableView registerClass:[MSMenuCell class] forCellReuseIdentifier:MSMenuCellReuseIdentifier];
    [self.tableView registerClass:[MSMenuTableViewHeader class] forHeaderFooterViewReuseIdentifier:MSDrawerHeaderReuseIdentifier];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    
    //导航条中的prompt
    self.navigationItem.prompt=@"通过代码自定义单元格";
    self.navigationItem.title=@"自定义表格演示";
    //在右侧添加按钮
    paneRevealRightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(doBookmarks)];
    self.navigationItem.rightBarButtonItem=paneRevealRightBarButtonItem;
    //在左侧添加按钮
    paneRevealLeftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(doSearch)];
    self.navigationItem.leftBarButtonItem=paneRevealLeftBarButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - MSMenuViewController

- (void)initialize
{
    self.paneViewControllerType = NSUIntegerMax;
    self.paneViewControllerTitles = @{
                                      @(MSPaneViewControllerTypeStylers) : @"Stylers",
                                      @(MSPaneViewControllerTypeDynamics) : @"Dynamics",
                                      @(MSPaneViewControllerTypeBounce) : @"Bounce",
                                      @(MSPaneViewControllerTypeGestures) : @"Gestures",
                                      @(MSPaneViewControllerTypeControls) : @"Controls",
                                      @(MSPaneViewControllerTypeMap) : @"Map",
                                      @(MSPaneViewControllerTypeEditableTable) : @"Editable Table",
                                      @(MSPaneViewControllerTypeLongTable) : @"Long Table",
                                      @(MSPaneViewControllerTypeMonospace) : @"Monospace Ltd."
                                      };
    self.paneViewControllerClasses = @{
                                       @(MSPaneViewControllerTypeStylers) : @"Stylers",
                                       @(MSPaneViewControllerTypeDynamics) : @"Dynamics",
                                       @(MSPaneViewControllerTypeBounce) : @"Bounce",
                                       @(MSPaneViewControllerTypeGestures) : @"Gestures",
                                       @(MSPaneViewControllerTypeControls) : @"Controls",
                                       @(MSPaneViewControllerTypeMap) : @"Map",
                                       @(MSPaneViewControllerTypeEditableTable) : @"Editable Table",
                                       @(MSPaneViewControllerTypeLongTable) : @"Long Table",
                                       @(MSPaneViewControllerTypeMonospace) : @"Monospace Ltd."
                                       };
    
    self.sectionTitles = @{
                           @(MSMenuViewControllerTableViewSectionTypeOptions) : @"Options",
                           @(MSMenuViewControllerTableViewSectionTypeExamples) : @"Examples",
                           @(MSMenuViewControllerTableViewSectionTypeAbout) : @"About",
                           };
    
    self.tableViewSectionBreaks = @[
                                    @(MSPaneViewControllerTypeControls),
                                    @(MSPaneViewControllerTypeMonospace),
                                    @(MSPaneViewControllerTypeCount)
                                    ];
}
- (MSPaneViewControllerType)paneViewControllerTypeForIndexPath:(NSIndexPath *)indexPath
{
    MSPaneViewControllerType paneViewControllerType;
    if (indexPath.section == 0) {
        paneViewControllerType = indexPath.row;
    } else {
        paneViewControllerType = ([self.tableViewSectionBreaks[(indexPath.section - 1)] integerValue] + indexPath.row);
    }
    NSAssert(paneViewControllerType < MSPaneViewControllerTypeCount, @"Invalid Index Path");
    return paneViewControllerType;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return MSMenuViewControllerTableViewSectionTypeCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        NSLog(@"%ld",(long)[self.tableViewSectionBreaks[section] integerValue]);
        return [self.tableViewSectionBreaks[section] integerValue];
    } else {
        NSLog(@"%ld",(long)[self.tableViewSectionBreaks[section] integerValue]);
        return ([self.tableViewSectionBreaks[section] integerValue] - [self.tableViewSectionBreaks[(section - 1)] integerValue]);
    }
}
#pragma mark - Table Section and cell style
/*返回每一个Section的自定义头*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:MSDrawerHeaderReuseIdentifier];
    headerView.textLabel.text = [self.sectionTitles[@(section)] uppercaseString];
    return headerView;
}
/*返回每一个Section的自定义头的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
/*返回每一个Section的自定义尾的高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MSMenuCellReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.paneViewControllerTitles[@([self paneViewControllerTypeForIndexPath:indexPath])];
    
    //填充行的详细内容
    cell.detailTextLabel.text = @"详细内容";
    cell.textLabel.backgroundColor= [UIColor greenColor];
    
    //表视图单元提供的UILabel属性，设置字体大小
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    //设置单元格UILabel属性背景颜色
    cell.textLabel.backgroundColor=[UIColor clearColor];
    //正常情况下现实的图片
    UIImage *image = [UIImage imageNamed:@"Logo"];
    cell.imageView.image=image;
    //被选中后高亮显示的照片
    UIImage *highLightImage = [UIImage imageNamed:@"Logo"];
    cell.imageView.highlightedImage = highLightImage;
    
    
    return cell;
    */
    MSMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:MSMenuCellReuseIdentifier forIndexPath:indexPath];
    NSString *title = self.paneViewControllerTitles[@([self paneViewControllerTypeForIndexPath:indexPath])];
    NSString *imageName = @"Left-Reveal-Icon.png";
    cell.textLabel.text=title;
    return cell;
}
//选中单元格所产生事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //首先是用indexPath获取当前行的内容
    NSInteger row = [indexPath row];
    //从数组中取出当前行内容
    NSString *rowValue = @"测试";
    NSString *message = [[NSString alloc]initWithFormat:@"你选择%@",rowValue];
    //    弹出警告信息
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles: nil];
    [alert show];
}
#pragma mark - BarButtonItemEvent
-(void)doBookmarks
{
    NSLog(@"doBookmarks");
}
-(void)doSearch
{
    NSLog(@"doSearch");
}
@end
