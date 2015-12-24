//
//  DetailViewController.h
//  RestKitTutorial
//
//  Created by Sergey Yuzepovich on 27.12.14.
//  Copyright (c) 2014 Sergey Yuzepovich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

