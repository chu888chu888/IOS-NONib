//
//  enumerate.h
//  iOSAppTemplate
//

//

#ifndef iOSAppTemplate_enumerate_h
#define iOSAppTemplate_enumerate_h
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SettingItemType) {
    TLSettingItemTypeDefault,       // image, title, rightTitle, rightImage
    TLSettingItemTypeDefaultL,      // image, title, leftImage, rightTitle
    TLSettingItemTypeLeft,          // image, title, leftTitle, leftImage
    TLSettingItemTypeButton,        // button
    TLSettingItemTypeAvatar,        // title, avatar
    TLSettingItemTypeMidTitle,      // title
    TLSettingItemTypeSwitch,        // title， Switch
};


#endif
