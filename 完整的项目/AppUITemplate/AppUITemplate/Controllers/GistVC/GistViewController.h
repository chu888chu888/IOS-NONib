//
//  GistViewController.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/16.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CommonTableViewController.h"
#import "GistDataSource.h"
@interface GistViewController : CommonTableViewController
@property(nonatomic,strong) GistDataSource *source;
@end
