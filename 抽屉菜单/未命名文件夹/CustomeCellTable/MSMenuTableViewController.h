//
//  MSMenuTableViewController.h
//  CustomeCellTable
//
//  Created by chuguangming on 15/1/23.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MSDynamicsDrawerViewController.h"
typedef NS_ENUM(NSUInteger, MSPaneViewControllerType)
{
    MSPaneViewControllerTypeStylers,
    MSPaneViewControllerTypeDynamics,
    MSPaneViewControllerTypeBounce,
    MSPaneViewControllerTypeGestures,
    MSPaneViewControllerTypeControls,
    MSPaneViewControllerTypeMap,
    MSPaneViewControllerTypeEditableTable,
    MSPaneViewControllerTypeLongTable,
    MSPaneViewControllerTypeMonospace,
    MSPaneViewControllerTypeCount
};
@interface MSMenuTableViewController : UITableViewController
@property (nonatomic, assign) MSPaneViewControllerType paneViewControllerType;
@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UITableViewCell *tableViewCell;

- (void)transitionToViewController:(MSPaneViewControllerType)paneViewControllerType;
@end
