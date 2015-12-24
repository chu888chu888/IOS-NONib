//
//  Venue.h
//  coffeekit
//
//  Created by giaunv on 4/3/15.
//  Copyright (c) 2015 366. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Location;
@class Stats;

@interface Venue : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) Stats *stats;

@end
