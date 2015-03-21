//
//  AccountInfoViewController.m
//  weAgent
//
//  Created by 王拓 on 14/12/17.
//  Copyright (c) 2014年 weAgent. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "EditUserInfoViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UpYun.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface AccountInfoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>

@end

@implementation AccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"账号信息"];
    self.view = [[AccountInfo alloc]init];
    self.view.listView.dataSource = self;
    self.view.listView.delegate = self;
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"name"] isEqualToString:@""]||[[NSUserDefaults standardUserDefaults] objectForKey:@"name"] == nil) {
        _nameLab.text =  @"未设置";
    }else{
        _nameLab.text =  [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    }
    
    _accountLab.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    [self loadPortrait];
    
    
}
#pragma mark tableView
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int section = (int)indexPath.section;
    int row = (int)indexPath.row;
    static NSString *CellIdentifier = @"InfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (section) {
            case 0:
            {
                if (row == 0) {
                    cell.textLabel.text = @"头像";
                    [cell addSubview:self.portraitImageView];
                    [self loadPortrait];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                if (row == 1) {
                    cell.textLabel.text = @"账号";
                    _accountLab = [[UILabel alloc]initWithFrame:CGRectMake([UIView globalWidth]*0.60, 10, 95, 30)];
                    _accountLab.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
                    _accountLab.textColor=[UIColor lightGrayColor];
                    _accountLab.font = [UIFont baseWithSize:14];
                    _accountLab.textAlignment = NSTextAlignmentRight;
                    [cell addSubview:_accountLab];
                }
                if (row == 2) {
                    cell.textLabel.text = @"名称";
                    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake([UIView globalWidth]*0.60, 10, 95, 30)];
                    _nameLab.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
                    _nameLab.textColor=[UIColor lightGrayColor];
                    _nameLab.font = [UIFont baseWithSize:14];
                    _nameLab.textAlignment = NSTextAlignmentRight;
                    [cell addSubview:_nameLab];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
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

    switch (row) {
        case 0:
            [self editPortrait];
            break;
        case 2:
            [self editNameHandle];
            break;

        default:
            break;
    }
    
}

-(void)editNameHandle{
    EditUserInfoViewController *EditUserInfoVC = [[EditUserInfoViewController alloc]init];
    EditUserInfoVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:EditUserInfoVC animated:YES];
}
#pragma mark portraitImageView 获得
- (UIImageView *)portraitImageView {
    if (!_portraitImageView) {
        CGFloat w = 64; CGFloat h = w;
        _portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIView globalWidth]*0.7, 8, w, h)];
        [_portraitImageView.layer setCornerRadius:(_portraitImageView.frame.size.height/2)];
        [_portraitImageView.layer setMasksToBounds:YES];
        [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_portraitImageView setClipsToBounds:YES];
        _portraitImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _portraitImageView.layer.shadowOffset = CGSizeMake(4, 4);
        _portraitImageView.layer.shadowOpacity = 0.5;
        _portraitImageView.layer.shadowRadius = 1.0;
        _portraitImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _portraitImageView.layer.borderWidth = 0.2f;
        _portraitImageView.userInteractionEnabled = YES;
        _portraitImageView.backgroundColor = [UIColor lightGrayColor];
        UITapGestureRecognizer *portraitTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait)];
        [_portraitImageView addGestureRecognizer:portraitTap];
    }
    return _portraitImageView;
}

- (void)loadPortrait {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]==nil) {
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
                        [[NSUserDefaults standardUserDefaults] setObject:self.getAvatarString forKey:@"avatar"];
                        self.portraitImageView.image = editedImage;
                        [UIImage SaveImageToLocal:editedImage Keys:[[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]];
                    };
                    uy.failBlocker = ^(NSError * error)
                    {
                        NSString *message = [error.userInfo objectForKey:@"message"];
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"error" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                        NSLog(@"%@",error);
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
