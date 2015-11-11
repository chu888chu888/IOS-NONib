//
//  TLUIHelper.m
//  iOSAppTemplate
//

//

#import "UIHelper.h"

@implementation UIHelper

+ (SettingGrounp *) getFriensListItemsGroup
{
    SettingItem *notify = [[SettingItem alloc] initWithTitle:@"新的朋友" imageName:@"plugins_FriendNotify"];
    SettingItem *friendGroup = [[SettingItem alloc] initWithTitle:@"群聊" imageName:@"add_friend_icon_addgroup"];
    SettingItem *tag = [[SettingItem alloc] initWithTitle:@"标签" imageName:@"Contact_icon_ContactTag"];
    SettingItem *offical = [[SettingItem alloc] initWithTitle:@"公众号" imageName:@"add_friend_icon_offical"];
    SettingGrounp *group = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:notify, friendGroup, tag, offical, nil];
    return group;
}

+ (NSMutableArray *) getMineVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    SettingItem *album = [[SettingItem alloc] initWithTitle:@"相册" imageName:@"MoreMyAlbum"];
    SettingItem *favorite = [[SettingItem alloc] initWithTitle:@"收藏" imageName:@"MoreMyFavorites"];
    SettingItem *bank = [[SettingItem alloc] initWithTitle:@"钱包" imageName:@"MoreMyBankCard"];
    SettingItem *card = [[SettingItem alloc] initWithTitle:@"卡包" imageName:@"MyCardPackageIcon"];
    SettingGrounp *group1 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:album, favorite, bank, card, nil];
    [items addObject:group1];
    
    SettingItem *expression = [[SettingItem alloc] initWithTitle:@"表情" imageName:@"MoreExpressionShops"];
    SettingGrounp *group2 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:expression, nil];
    [items addObject:group2];
    
    SettingItem *setting = [[SettingItem alloc] initWithTitle:@"设置" imageName:@"MoreSetting"];
    SettingGrounp *group3 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:setting, nil];
    [items addObject:group3];
    
    return items;
}

+ (NSMutableArray *) getDiscoverItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    SettingItem *friendsAlbum = [[SettingItem alloc] initWithTitle:@"朋友圈" subTitle:nil imageName:@"ff_IconShowAlbum" subImageName:@"2.jpg"];
    SettingGrounp *group1 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:friendsAlbum, nil];
    [items addObject:group1];
    
    SettingItem *qrCode = [[SettingItem alloc] initWithTitle:@"扫一扫" imageName:@"ff_IconQRCode"];
    SettingItem *shake = [[SettingItem alloc] initWithTitle:@"摇一摇" imageName:@"ff_IconShake"];
    SettingGrounp *group2 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:qrCode, shake, nil];
    [items addObject:group2];
    
    SettingItem *loacation = [[SettingItem alloc] initWithTitle:@"附近的人" subTitle:@"" imageName:@"ff_IconLocationService" subImageName:@"FootStep" type: TLSettingItemTypeDefaultL];
    SettingItem *bottle = [[SettingItem alloc] initWithTitle:@"漂流瓶" imageName:@"ff_IconBottle"];
    SettingGrounp *group3 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:loacation, bottle, nil];
    [items addObject:group3];
    
    SettingItem *shopping = [[SettingItem alloc] initWithTitle:@"购物" imageName:@"CreditCard_ShoppingBag"];
    SettingItem *game = [[SettingItem alloc] initWithTitle:@"游戏" subTitle:@"超火力新枪战" imageName:@"MoreGame" subImageName:@"game_tag_icon"];
    SettingGrounp *group4 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:shopping, game, nil];
    [items addObject:group4];
    
    return items;
}

+ (NSMutableArray *) getDetailVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    SettingItem *tag = [[SettingItem alloc] initWithTitle:@"设置备注和标签"];
    SettingItem *phone = [[SettingItem alloc] initWithTitle:@"电话号码" subTitle:@"18888888888" type:TLSettingItemTypeLeft];
    SettingGrounp *group1 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:tag, phone, nil];
    [items addObject:group1];
    SettingItem *position = [[SettingItem alloc] initWithTitle:@"地区" subTitle:@"山东 青岛" type:TLSettingItemTypeLeft];
    SettingItem *album = [[SettingItem alloc] initWithTitle:@"个人相册" subImages:[NSMutableArray arrayWithObjects:@"1.jpg", @"2.jpg", @"8.jpg", @"0.jpg", nil]];
    SettingItem *more = [[SettingItem alloc] initWithTitle:@"更多" type:TLSettingItemTypeLeft];
    SettingGrounp *group2 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:position, album, more, nil];
    [items addObject:group2];
    
    SettingItem *chatButton = [[SettingItem alloc] initWithTitle:@"发消息"  type:TLSettingItemTypeButton];
    SettingItem *videoButton = [[SettingItem alloc] initWithTitle:@"视频聊天"  type:TLSettingItemTypeButton];
    SettingGrounp *group3 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:chatButton, videoButton, nil];
    [items addObject:group3];
    
    return items;
}

+ (NSMutableArray *) getMineDetailVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    SettingItem *avatar = [[SettingItem alloc] initWithTitle:@"头像" subImageName:@"0.jpg" type:TLSettingItemTypeAvatar];
    SettingItem *name = [[SettingItem alloc] initWithTitle:@"名字" subTitle:@"Bay、栢"];
    SettingItem *num = [[SettingItem alloc] initWithTitle:@"微信号" subTitle:@"li-bokun"];
    SettingItem *code = [[SettingItem alloc] initWithTitle:@"我的二维码"];
    SettingItem *address = [[SettingItem alloc] initWithTitle:@"我的地址"];
    SettingGrounp *frist = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:avatar, name, num, code, address, nil];
    [items addObject:frist];
    
    SettingItem *sex = [[SettingItem alloc] initWithTitle:@"性别" subTitle:@"男"];
    SettingItem *pos = [[SettingItem alloc] initWithTitle:@"地址" subTitle:@"山东 滨州"];
    SettingItem *proverbs = [[SettingItem alloc] initWithTitle:@"个性签名" subTitle:@"Hello world!"];
    SettingGrounp *second = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:sex, pos, proverbs, nil];
    [items addObject:second];
    
    return items;
}

+ (NSMutableArray *) getSettingVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    SettingItem *safe = [[SettingItem alloc] initWithTitle:@"账号和安全" subTitle:@"已保护" imageName:nil subImageName:@"ProfileLockOn" type:TLSettingItemTypeDefaultL];
    SettingGrounp *group1 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:safe, nil];
    [items addObject:group1];
    
    SettingItem *noti = [[SettingItem alloc] initWithTitle:@"新消息通知"];
    SettingItem *privacy = [[SettingItem alloc] initWithTitle:@"隐私"];
    SettingItem *normal = [[SettingItem alloc] initWithTitle:@"通用"];
    SettingGrounp *group2 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:noti, privacy, normal, nil];
    [items addObject:group2];
    
    SettingItem *about = [[SettingItem alloc] initWithTitle:@"关于微信"];
    SettingGrounp *group3 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:about, nil];
    [items addObject:group3];
    
    SettingItem *exit = [[SettingItem alloc] initWithTitle:@"退出登陆" type:TLSettingItemTypeMidTitle];
    SettingGrounp *group4 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:exit, nil];
    [items addObject:group4];
    
    return items;
}

+ (NSMutableArray *) getDetailSettingVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];

    SettingItem *tag = [[SettingItem alloc] initWithTitle:@"设置备注及标签"];
    SettingGrounp *group1 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:tag, nil];
    [items addObject:group1];

    SettingItem *recommend = [[SettingItem alloc] initWithTitle:@"把他推荐给好友"];
    SettingGrounp *group2 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:recommend, nil];
    [items addObject:group2];
    
    SettingItem *starFriend = [[SettingItem alloc] initWithTitle:@"把它设为星标朋友" type:TLSettingItemTypeSwitch];
    SettingGrounp *group3 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:starFriend, nil];
    [items addObject:group3];
    
    SettingItem *prohibit = [[SettingItem alloc] initWithTitle:@"不让他看我的朋友圈" type:TLSettingItemTypeSwitch];
    SettingItem *ignore = [[SettingItem alloc] initWithTitle:@"不看他的朋友圈" type:TLSettingItemTypeSwitch];
    SettingGrounp *group4 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:prohibit, ignore, nil];
    [items addObject:group4];
    
    SettingItem *addBlacklist = [[SettingItem alloc] initWithTitle:@"加入黑名单" type:TLSettingItemTypeSwitch];
    SettingItem *report = [[SettingItem alloc] initWithTitle:@"举报"];
    SettingGrounp *group5 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:addBlacklist, report, nil];
    [items addObject:group5];
    
    SettingItem *delete = [[SettingItem alloc] initWithTitle:@"删除好友" type:TLSettingItemTypeButton];
    SettingGrounp *group6 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:delete, nil];
    [items addObject:group6];

    return items;
}

+ (NSMutableArray *) getNewNotiVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    SettingItem *recNoti = [[SettingItem alloc] initWithTitle:@"接受新消息通知" subTitle:@"已开启"];
    SettingGrounp *group1 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:@"如果你要关闭或开启微信的新消息通知，请在iPhone的\"设置\" - \"通知\"功能中，找到应用程序\"微信\"更改。" settingItems:recNoti, nil];
    [items addObject:group1];
    
    SettingItem *showDetail = [[SettingItem alloc] initWithTitle:@"通知显示详情信息" type:TLSettingItemTypeSwitch];
    SettingGrounp *group2 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:@"关闭后，当收到微信消息时，通知提示将不显示发信人和内容摘要。" settingItems:showDetail, nil];
    [items addObject:group2];
    
    SettingItem *disturb = [[SettingItem alloc] initWithTitle:@"功能消息免打扰"];
    SettingGrounp *group3 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:@"设置系统功能消息提示声音和振动时段。" settingItems:disturb, nil];
    [items addObject:group3];
    
    SettingItem *voice = [[SettingItem alloc] initWithTitle:@"声音" type:TLSettingItemTypeSwitch];
    SettingItem *shake = [[SettingItem alloc] initWithTitle:@"震动" type:TLSettingItemTypeSwitch];
    SettingGrounp *group4 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:@"当微信在运行时，你可以设置是否需要声音或者振动。" settingItems:voice, shake, nil];
    [items addObject:group4];

    SettingItem *friends = [[SettingItem alloc] initWithTitle:@"朋友圈照片更新" type:TLSettingItemTypeSwitch];
    SettingGrounp *group5 = [[SettingGrounp alloc] initWithHeaderTitle:nil footerTitle:@"关闭后，有朋友更新照片时，界面下面的“发现”切换按钮上不再出现红点提示。" settingItems:friends, nil];
    [items addObject:group5];

    return items;
}

@end
