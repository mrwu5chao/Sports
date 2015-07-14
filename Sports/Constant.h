//
//  Constant.h
//  Sports
//
//  Created by 吴超 on 15/6/27.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#ifndef Sports_Constant_h
#define Sports_Constant_h

#import "UIView+ViewFrameGeometry.h"
#import "UIImage+ResizeImage.h"
#import "MFSideMenuContainerViewController.h"
#import "AppDelegate.h"
#import "SIAlertView.h"
#import "PengActionSheet.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
#import <BaiduMapAPI/BMapKit.h>
#import "EaseMob.h"
#import "UIViewController+HUD.h"
#import "EaseMob.h"
#import "ChatDemoUIDefine.h"
#import "EMAlertView.h"
#endif
//APPKEY
#define BAIDUAPPKEY @"ffc7j2COph0AUxQDkbfgVL7Y"
#define BMOBAPPKEY @"e0a51d14600117cad4ca75e56c30b837"
#define SMSAPPKEY @"7ddf5bab58a2"
#define SMSAPPSECRET @"6469f9bd2798b3c5a0c1d3fcdab517f9"
#define UMAPPKEY  @"5438e10cfd98c54d0b0268ef"

// UI_SCREEN
#define UI_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define UI_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

// SYSTEM_VERSION
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define IS_iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define IS_iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

// UI_COLOR
#define UIColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0f green:((float)((hexValue & 0xFF00) >> 8))/255.0f blue:((float)(hexValue & 0xFF))/255.0f alpha:1.0]
#define UIColorFromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

#define DEFAULT_BG_COLOR [UIColor colorWithRed:236/255.0f green:236/255.0f blue:236/255.0f alpha:1.0f]
