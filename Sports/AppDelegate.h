//
//  AppDelegate.h
//  Sports
//
//  Created by 吴超 on 15/6/26.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IndexViewController;
@class DDMenuController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDMenuController *menuController;
@property (strong, nonatomic) IndexViewController *indexVC;

+ (AppDelegate *)defaultAppDelegate;
/**
 *  显示loading
 *
 *  @param message 提示文字
 */
- (void)showLoading:(NSString *)message;

/**
 *  隐藏loading
 */
- (void)hiddenLoading;

/**
 *  显示提示文字
 *
 *  @param message 提示文字
 */
- (void)showHint:(NSString *)message Timer:(float)timer;
@end

