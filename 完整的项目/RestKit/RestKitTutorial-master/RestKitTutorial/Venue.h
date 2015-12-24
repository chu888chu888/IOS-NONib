//
//  Venue.h
//  RestKitTutorial
//
//  Created by Sergey Yuzepovich on 27.12.14.
//  Copyright (c) 2014 Sergey Yuzepovich. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Location;
@class Stats;

@interface Venue : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Location *location;
@property (strong, nonatomic) Stats *stats;
    
@end
