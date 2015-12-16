//
//  BaseSource.h
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/16.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseSource : NSObject
@property(nonatomic,strong) NSOperationQueue *operationQueue;
-(NSDictionary *)dictionaryFromResponseData:(NSData *)responseData jsonPatternFile:(NSString *)jsonFile;
@end
