//
//  KMNetworkLoadingViewController.m
//  BigCentral
//
//  Created by Kevin Mindeguia on 19/11/2013.
//  Copyright (c) 2013 iKode Ltd. All rights reserved.
//

#import "KMNetworkLoadingViewController.h"

@interface KMNetworkLoadingViewController ()

@end

@implementation KMNetworkLoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark View LifeCycle
- (void)loadView
{
    /*
    @property (weak, nonatomic)  UIView *loadingView;
    @property (weak, nonatomic)  UIView *errorView;
    @property (weak, nonatomic)  UIButton *refreshButton;
    @property (weak, nonatomic)  KMActivityIndicator *activityIndicatorView;
    @property (weak, nonatomic)  UIView *noContentView;
     */

    _loadingView=[[UIView alloc]initWithFrame: [ UIScreen mainScreen ].applicationFrame];
    _activityIndicatorView=[[KMActivityIndicator alloc]initWithFrame:CGRectMake(300, 100, 40, 40)];
    UILabel *loadLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [_loadingView addSubview:_activityIndicatorView];
    [_loadingView addSubview:loadLabel];
    
    
    _errorView=[[UIView alloc]initWithFrame: [ UIScreen mainScreen ].applicationFrame];
    
    _noContentView=[[UIView alloc]initWithFrame: [ UIScreen mainScreen ].applicationFrame];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showLoadingView];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.activityIndicatorView startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLoadingView
{
    self.errorView.hidden = YES;
    self.activityIndicatorView.color = [UIColor colorWithRed:232.0/255.0f green:35.0/255.0f blue:111.0/255.0f alpha:1.0];
}

- (void)showErrorView
{
    self.noContentView.hidden = YES;
    self.errorView.hidden = NO;
}

- (void)showNoContentView;
{
    self.noContentView.hidden = NO;
    self.errorView.hidden = YES;
}

#pragma mark -
#pragma mark Action Methods

- (IBAction)retryRequest:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(retryRequest)])
        [self.delegate retryRequest];
    [self showLoadingView];
}
@end
