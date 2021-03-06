//
//  PhotoCollectionViewController.m
//  GCDDemoError
//
//  Created by chuguangming on 15/3/21.
//  Copyright (c) 2015年 chu. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotoManager.h"
#import "Utils.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ELCImagePickerController.h"
#import "PhotoCell.h"
#import "LineLayout.h"
#define kVerticalMarginForCollectionViewItems 0
#define kBackgroundImageOpacity 0.5f

@interface PhotoCollectionViewController ()
@property (nonatomic, strong) ALAssetsLibrary *library;
@property (nonatomic, strong) UIPopoverController *popController;
@end

@implementation PhotoCollectionViewController

#pragma mark - LifeCycle
- (void)SetupNav {
    self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
    self.navigationItem.title=@"相册";
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPhotoAssets)];
    self.navigationItem.rightBarButtonItem = addBarButton;
}

- (void)SetupCollectionView {
   
    LineLayout *lineLayout=[[LineLayout alloc]init];
    self.collectionView=[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:lineLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    //注册自定义Cell
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"PhotoCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentChangedNotification:)
                                                 name:kPhotoManagerContentUpdateNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentChangedNotification:)
                                                 name:kPhotoManagerAddedContentNotification
                                               object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.library = [[ALAssetsLibrary alloc] init];
    //设置导航条
    [self SetupNav];
    [self SetupCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -UICollectionViewDataSource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count=[[[PhotoManager sharedManager]photos] count];
    return count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PhotoCell";
    PhotoCell *cell = (PhotoCell*)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSArray *photoAssets = [[PhotoManager sharedManager] photos];
    Photo *photo = photoAssets[indexPath.row];
    switch (photo.status) {
        case PhotoStatusGoodToGo:
            cell.ImageView.image = [photo thumbnail];
            break;
        case PhotoStatusDownloading:
            cell.ImageView.image=[UIImage imageNamed:@"photoDownloading"];
            break;
        case PhotoStatusFailed:
            cell.ImageView.image = [UIImage imageNamed:@"photoDownloadError"];
        default:
            break;
    }
    return cell;
}

#pragma mark - UIBarButtonItem method
/// The upper right UIBarButtonItem method
- (void)addPhotoAssets
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"获取图片:"
                                                        delegate:self
                                                        cancelButtonTitle:@"取消"
                                                        destructiveButtonTitle:nil
                                                        otherButtonTitles:@"相册", @"互联网", nil];
    [actionSheet showInView:self.view];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    static const NSInteger kButtonIndexPhotoLibrary = 0;
    static const NSInteger kButtonIndexInternet = 1;
    if (buttonIndex == kButtonIndexPhotoLibrary)
    {
        ELCImagePickerController *imagePickerController = [[ELCImagePickerController alloc] init];
        [imagePickerController setImagePickerDelegate:self];
        
        if (isIpad())
        {
            if (![self.popController isPopoverVisible])
            {
                self.popController = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
                
                [self.popController presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
        } else
        {
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    } else if (buttonIndex == kButtonIndexInternet) {
        [self downloadImageAssets];
    }
}
//*****************************************************************************/
#pragma mark - elcImagePickerControllerDelegate
//*****************************************************************************/

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    for (NSDictionary *dictionary in info) {
        NSLog(@"dictionary:%@",dictionary[UIImagePickerControllerReferenceURL] );
        
        [self.library assetForURL:dictionary[UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset) {
            Photo *photo = [[Photo alloc] initWithAsset:asset];
            [[PhotoManager sharedManager] addPhoto:photo];
        } failureBlock:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"权限拒绝"
                                                            message:@"请在设置中,保证设置正常"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
    
    if (isIpad()) {
        [self.popController dismissPopoverAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    if (isIpad()) {
        [self.popController dismissPopoverAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//*****************************************************************************/
#pragma mark - Private Methods
//*****************************************************************************/

- (void)contentChangedNotification:(NSNotification *)notification
{
    [self.collectionView reloadData];
    [self showOrHideNavPrompt];
}

- (void)showOrHideNavPrompt
{
    // Implement me!
}

- (void)downloadImageAssets
{
    [[PhotoManager sharedManager] downloadPhotosWithCompletionBlock:^(NSError *error) {
        
        // This completion block currently executes at the wrong time
        NSString *message = error ? [error localizedDescription] : @"图片已经从互联网中下载完成....";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下载完成"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
