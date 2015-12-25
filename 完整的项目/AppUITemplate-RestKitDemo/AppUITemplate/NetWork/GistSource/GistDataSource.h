//
//  GistDataSource.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/16.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "BaseSource.h"
typedef void (^GistDataSourceCompletionBlock)(NSMutableArray * data,NSString * errorString);

@interface GistDataSource : BaseSource
+(GistDataSource *)discoverSource;
-(void)getGistList:(NSString *)pageLimit completion:(GistDataSourceCompletionBlock)completionBlock;
@end
