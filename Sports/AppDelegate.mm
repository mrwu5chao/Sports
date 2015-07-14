//
//  AppDelegate.m
//  Sports
//
//  Created by 吴超 on 15/6/26.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "IndexViewController.h"
#import "LeftMenuViewController.h"
#import <BmobSDK/Bmob.h>
#import <SMS_SDK/SMS_SDK.h>
#import "UMSocial.h"
#import "MobClick.h"
@interface AppDelegate ()
{
    MBProgressHUD *_hud;
    BMKMapManager *_mapManager;
}
@end

@implementation AppDelegate
@synthesize indexVC = _indexVC;
@synthesize menuController = _menuController;

+ (AppDelegate *)defaultAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
- (IndexViewController *)indexController {
    return [[IndexViewController alloc] init];
}

- (UINavigationController *)navigationController {
    return [[UINavigationController alloc]
            initWithRootViewController:[self indexController]];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //registerSDKWithAppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"yuedongapp#yuedong" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"15913358178" password:@"123456" completion:^(NSDictionary *loginInfo, EMError *error) {
        NSLog(@"loginInfo  ---- %@",loginInfo);
    } onQueue:nil];
    
    [self setIndexViewController];
    [self creatAppKey];
    
    
    return YES;
}

/**
 *  主界面
 */
- (void)setIndexViewController {
    LeftMenuViewController *leftMenuViewController = [[LeftMenuViewController alloc] init];
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:[self navigationController]
                                                    leftMenuViewController:leftMenuViewController
                                                    rightMenuViewController:nil];
    self.window.rootViewController = container;
    [self.window makeKeyAndVisible];

}


/**
 *  设置appkey
 */
- (void)creatAppKey {
    
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:BAIDUAPPKEY  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    // 友盟统计
    [MobClick startWithAppkey:UMAPPKEY reportPolicy:SEND_INTERVAL channelId:@"App Store"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];

    [UMSocialData setAppKey:UMAPPKEY];
    [Bmob registerWithAppKey:BMOBAPPKEY];
    
    [SMS_SDK registerApp:SMSAPPKEY withSecret:SMSAPPSECRET];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -ShowHUD
/**
 *  显示loading
 *
 *  @param message 提示文字
 */
- (void)showLoading:(NSString *)message {
    
    [[MBProgressHUD showHUDAddedTo:self.window animated:YES] setLabelText:message];
    
}

/**
 *  隐藏loading
 */
- (void)hiddenLoading {
    [MBProgressHUD hideAllHUDsForView:self.window animated:YES];
}

/**
 *  显示提示文字
 *
 *  @param message 提示文字
 */
- (void)showHint:(NSString *)message Timer:(float)timer {
    [[MBProgressHUD showMessageToView:self.window timer:timer animated:YES] setLabelText:message];
}

@end
