//
//  TLUIHelper.h
//  iOSAppTemplate
//

//

#import <Foundation/Foundation.h>
#import "TLSetting.h"

@interface UIHelper : NSObject

+ (SettingGrounp *) getFriensListItemsGroup;
+ (NSMutableArray *) getDiscoverItems;
+ (NSMutableArray *) getMineVCItems;
+ (NSMutableArray *) getDetailVCItems;
+ (NSMutableArray *) getDetailSettingVCItems;
+ (NSMutableArray *) getMineDetailVCItems;

+ (NSMutableArray *) getSettingVCItems;
+ (NSMutableArray *) getNewNotiVCItems;


@end
