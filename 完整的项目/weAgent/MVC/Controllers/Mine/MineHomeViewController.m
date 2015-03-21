//
//  MineHomeViewController.m
//  weChat
//
//  Created by apple on 14-9-1.
//  Copyright (c) 2014年 marenqing. All rights reserved.
//

#import "MineHomeViewController.h"
#import "MyAccountViewController.h"
#import "CustomeServiceViewController.h"
#import "GlobalNavigationViewController.h"
#import "VersionViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UpYun.h"
#import "ChangePasswordViewController.h"
#import "AccountInfoViewController.h"

#define ORIGINAL_MAX_WIDTH 640.0f
#define PLEASE_LOGIN @"请重新登录"
@interface MineHomeViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>
{
    UILabel *nameLab;
    UILabel *phoneLab;
    UIImageView *portraitImageView;
}

@end

@implementation MineHomeViewController

#pragma mark 生命周期
- ( void ) loadView {
    self.view = [[MineHome alloc] init];
    self.view.listView.dataSource = self;
    self.view.listView.delegate = self;
    self.view.listView.backgroundColor = [UIColor baseBackgroundColor];
    [self.view.logoff addTarget:self action:@selector(logoffHandle) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"我"];
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.view.listView deselectRowAtIndexPath:[self.view.listView indexPathForSelectedRow] animated:YES];
    [self loadAccount];
    //改这里时注意同时改下面
    [self loadPortrait];
}

#pragma mark portraitImageView 获得
- (UIImageView *)portraitImageView {
    if (!portraitImageView) {
        CGFloat w = 64; CGFloat h = w;
        portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, w, h)];
        [portraitImageView.layer setCornerRadius:(portraitImageView.frame.size.height/2)];
        [portraitImageView.layer setMasksToBounds:YES];
        [portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [portraitImageView setClipsToBounds:YES];
        portraitImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
        portraitImageView.layer.shadowOpacity = 0.5;
        portraitImageView.layer.shadowRadius = 1.0;
        portraitImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        portraitImageView.layer.borderWidth = 0.2f;
        portraitImageView.userInteractionEnabled = YES;
        portraitImageView.backgroundColor = [UIColor lightGrayColor];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [portraitImageView addGestureRecognizer:portraitTap];
    }
    return portraitImageView;
}

- (void)loadAccount {
    //异步加载图片
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"name"] isEqualToString:@""]||[[NSUserDefaults standardUserDefaults] objectForKey:@"name"] == nil) {
        nameLab.text =  @"未设置";
    }else{
        nameLab.text =  [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] isEqualToString:@""]||[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] == nil) {
        phoneLab.text = PLEASE_LOGIN;
        
    }else{
        phoneLab.text =  [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    }
    
    
}

- (void)loadPortrait {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]==nil||[[[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"] isEqualToString:@""]) {
        self.portraitImageView.image = [UIImage imageNamed:@"Icon180*180"];
    }else{
        if ([UIImage LocalHaveImage:[[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]]) {
            self.portraitImageView.image = [UIImage GetImageFromLocal:[[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]];
        }else{
            //异步加载图片
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
                NSURL *portraitUrl = [NSURL URLWithString:[@"http://weestate.b0.upaiyun.com" stringByAppendingString:self.getSaveKey]];
                [portraitUrl removeAllCachedResourceValues];
                UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.portraitImageView.image = protraitImg;
                    [UIImage SaveImageToLocal:protraitImg Keys:[[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]];
                });
            });
        }
    }
}

- (void)editPortrait {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]==nil||[[[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"] isEqualToString:@""]) {
        [self loginHandle];
    }else{
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"拍照", @"从相册中选取", nil];
        [choiceSheet showInView:self.view];
        
    }
    
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
        NSString *avatarString =[self getAvatarString];
        NSDictionary *NSDparameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"diploma"],@"diploma",avatarString,@"avatar",nil];
        
        DSJSONRPCCompletionHandler completionHandler = ^(NSString *methodName, NSInteger callId, id methodResult, DSJSONRPCError *methodError, NSError *internalError) {
            RPCMainHandler RPCMainHandler= ^(id methodResult){
                if ([[methodResult objectForKey:@"code"] isEqualToString:@"120100"]) {
                    
                    UpYun *uy = [[UpYun alloc] init];
                    uy.successBlocker = ^(id data)
                    {
                         [UIImage SaveImageToLocal:editedImage Keys:[[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]];
                        self.portraitImageView.image = editedImage;
                       
                    };
                    uy.failBlocker = ^(NSError * error)
                    {
                        NSString *message = [error.userInfo objectForKey:@"message"];
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"error" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                    };
                    
                    [uy uploadFile:editedImage saveKey:[self getSaveKey]];
                    
                }
                
            };
            
            
            [self validateCode:methodResult withRequestIdentification:self.requestIdentification andParameters:NSDparameters onCompletion:RPCMainHandler];
            
        };
        [self RPCUseClass:@"Users" callMethodName:@"upload" withParameters:NSDparameters onCompletion:completionHandler];
        
        
    }];
}

/**
 * 由开发者生成saveKey
 */
-(NSString * )getSaveKey {
    return [NSString stringWithFormat:@"/avatar/%@/%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"id"],self.getAvatarString];
}

//生成图片名
-(NSString *)getAvatarString {
    return [NSString stringWithFormat:@"weagent_avatar_%@.jpg",[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]];
}


- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
            //            NSLog(@"234");
        }];
    }];
}

//点击取消得事件操作
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}



#pragma mark 各种点击
- (void)myAccountHandle{
//    MyAccountViewController *myAccountTVC = [[MyAccountViewController alloc] init];
//    myAccountTVC.hidesBottomBarWhenPushed=YES;//要显示的viewController设置
//    [self.navigationController pushViewController:myAccountTVC animated:YES];
    
    ChangePasswordViewController *changPasswordVC = [[ChangePasswordViewController alloc]init];
    changPasswordVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:changPasswordVC animated:YES];
}

- (void)updateHandle{
    VersionViewController *versionVC = [[VersionViewController alloc] init];
    versionVC.hidesBottomBarWhenPushed=YES;//要显示的viewController设置
    [self.navigationController pushViewController:versionVC animated:YES];
}

- (void)customServiceHandle{
    CustomeServiceViewController *customeServiceTVC = [[CustomeServiceViewController alloc] init];
    customeServiceTVC.hidesBottomBarWhenPushed=YES;//要显示的viewController设置
    [self.navigationController pushViewController:customeServiceTVC animated:YES];
}

- (void)logoffHandle{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"diploma"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"avatar"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"id"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"name"];
    [self loginHandle];
    
}

- (void)accountInfoHandle{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] == nil || [[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"] isEqualToString:@""]) {
        [self loginHandle];
        return;
    }
    
    AccountInfoViewController *changPasswordVC = [[AccountInfoViewController alloc]init];
    changPasswordVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:changPasswordVC animated:YES];
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma mark tableView
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }else{
        return 0;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 130;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((int)indexPath.section == 0){
        return 88;
        
    }else{
        return 44;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 1) {
        return 3;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
    static NSString *CellIdentifier = @"mineCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (section) {
            case 0:
            {
                nameLab = [[UILabel alloc] initWithFrame:CGRectMake(88,20, 200, 24)];
                phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(88,44, 200, 24)];
                phoneLab.font = [UIFont baseWithSize:14];
                phoneLab.textColor = [UIColor grayColor];
                
                [self loadAccount];
                [self loadPortrait];
                [cell addSubview:self.portraitImageView];
                [cell addSubview:nameLab];
                [cell addSubview:phoneLab];
            }
                break;
                
            case 1:
                if(row == 0)
                {
                    cell.textLabel.text =  @"修改密码";
                    [cell.imageView setImage:[self reSizeImage:[UIImage imageNamed:@"change"] toSize:CGSizeMake(20.0f, 20.0f)]];
                }
                
                if(row == 1){
                    cell.textLabel.text =  @"微中介客服中心";
                    [cell.imageView setImage:[self reSizeImage:[UIImage imageNamed:@"kfbz"] toSize:CGSizeMake(20.0f, 20.0f)]];
                    
                }
                if(row == 2){
                    cell.textLabel.text =  @"关于微中介";
                    [cell.imageView setImage:[self reSizeImage:[UIImage imageNamed:@"info"] toSize:CGSizeMake(20.0f, 20.0f)]];
                }

                break;
                
                
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = (int)indexPath.row;
    int section = (int)indexPath.section;
    switch (section) {
        case 0:
            if (row == 0) {
                [self accountInfoHandle];
            }
            break;
        case 1:
            if(row == 0)
            {
                [self myAccountHandle];
                
            }
            if(row == 1){
                [self customServiceHandle];
                
            }
            if(row == 2){
                [self updateHandle];
            }
            
            break;
            
            
        default:
            break;
    }
    
}

@end
