//
//  ConversationSearchViewController.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/11/13.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "CommonTableViewController.h"

@interface ConversationSearchViewController : CommonTableViewController<UISearchResultsUpdating>
@property (nonatomic, copy) NSMutableArray *ConversationsArray;
@end
