//
//  VenueCell.h
//  RestKitTutorial
//
//  Created by Sergey Yuzepovich on 27.12.14.
//  Copyright (c) 2014 Sergey Yuzepovich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UILabel *checkinsLabel;

@end
