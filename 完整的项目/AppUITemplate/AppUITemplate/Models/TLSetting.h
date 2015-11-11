//
//  TLSetting.h
//  iOSAppTemplate
//

//

#import <Foundation/Foundation.h>

@interface SettingItem : NSObject

@property (nonatomic, assign) SettingItemType type;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *subImageName;
@property (nonatomic, strong) NSMutableArray *subImages;
@property (nonatomic, strong) NSURL *subImageURL;

- (id) initWithTitle:(NSString *)title;
- (id) initWithTitle:(NSString *)title subImageName:(NSString *)subImageName;
- (id) initWithTitle:(NSString *)title subImages:(NSMutableArray *)subImages;
- (id) initWithTitle:(NSString *)title type:(SettingItemType)type;
- (id) initWithTitle:(NSString *)title imageName:(NSString *)imageName;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle type:(SettingItemType)type;
- (id) initWithTitle:(NSString *)title subImageName:(NSString *)subImageName type:(SettingItemType)type;

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageName:(NSString *)subImageName;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageName:(NSString *)subImageName type:(SettingItemType)type;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageURL:(NSURL *)subImageURL type:(SettingItemType)type;

@end

@interface SettingGrounp : NSObject

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) NSUInteger itemsCount;

- (id) initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle settingItems:(SettingItem *)firstObj, ...;

- (SettingItem *) itemAtIndex:(NSUInteger)index;

@end

