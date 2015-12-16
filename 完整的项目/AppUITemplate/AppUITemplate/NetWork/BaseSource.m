//
//  BaseSource.m
//  AppUITemplate
//
//  Created by 楚广明 on 15/12/16.
//  Copyright © 2015年 楚广明. All rights reserved.
//

#import "BaseSource.h"

@implementation BaseSource
-(id)init
{
    self=[super init];
    if (self) {
        self.operationQueue=[[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount=1;
    }
    return self;
}
#pragma mark -
#pragma mark Response Data Parsing
-(NSDictionary *)dictionaryFromResponseData:(NSData *)responseData jsonPatternFile:(NSString *)jsonFile
{
    NSDictionary *dictionary=nil;
    if (responseData) {
        id object=[NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        if ([object isKindOfClass:[NSDictionary class]])
        {
            dictionary = (NSDictionary*)object;
        }
        else
        {
            if (object)
                dictionary = [NSDictionary dictionaryWithObject:object forKey:@"results"];
            else
                dictionary = nil;
        }
    }
    return dictionary;
}
@end
