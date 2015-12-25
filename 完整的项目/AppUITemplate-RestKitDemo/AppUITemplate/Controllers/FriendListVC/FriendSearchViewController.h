//
//  FriendSearchViewController.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/10/30.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CommonTableViewController.h"

@interface FriendSearchViewController : CommonTableViewController<UISearchResultsUpdating>
@property(nonatomic,copy) NSMutableArray *friendsArray;
@end
