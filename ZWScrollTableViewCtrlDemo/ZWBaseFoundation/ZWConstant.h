//
//  ZWConstant.h
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWConstant : NSObject

#define kMainAPIDomain @""
#define kAppItunesId @""

#define kIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define kColorRGB(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

#define kIsIOS9Later [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
#define kIsIOS8Later [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define kIsIOS7Later [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
//NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1

#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//#define kScreenSize [UIScreen mainScreen].bounds.size
#define kScreenSize [UIScreen mainScreen].applicationFrame.size

#define kIsIphone4s (kScreenSize.height == (480-20))
#define kIsIphone5 (kScreenSize.height == (568-20))

#define kNetworkConnectFailTip @"网络连接失败!"
#define kEmptyDataTip @"当前没有更多的消息哦!"

// 图片路径
#define kResourceSrcName(file) [@"ResourceImages.bundle" stringByAppendingPathComponent:file]

// 通知
#define kNotificationNameByMenuSelected @"MenuSelectedNotification"

@end
