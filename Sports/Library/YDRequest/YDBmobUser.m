//
//  YDBmobUser.m
//  Sports
//
//  Created by 吴超 on 15/6/30.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "YDBmobUser.h"
#import <BmobSDK/BmobUser.h>
#import <BmobIM/BmobUserManager.h>
#import <BmobSDK/BmobQuery.h>

#import "Location.h"
#import "LoginViewController.h"
@implementation YDBmobUser
/**
 *  用户登录
 *
 *  @param mobile   用于账号（手机号码）
 *  @param password 密码
 *  @param block    结果
 */
+ (void)YDLoginWithMobile:(NSString *)mobile Password:(NSString *)password Block:(BmobUserResultBlock)block {
    [BmobUser loginWithUsernameInBackground:mobile password:password block:^(BmobUser *user, NSError *error) {
        if (!error) {
            //启动定位
            CLLocationDegrees longitude     = [[Location shareInstance] currentLocation].longitude;
            CLLocationDegrees latitude      = [[Location shareInstance] currentLocation].latitude;
            CLLocationCoordinate2D gpsCoor  = CLLocationCoordinate2DMake(latitude, longitude);

            CLLocationCoordinate2D bmapCoor = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(gpsCoor,BMK_COORDTYPE_GPS));
            BmobGeoPoint *location          = [[BmobGeoPoint alloc] initWithLongitude:bmapCoor.longitude WithLatitude:bmapCoor.latitude];
            [user setObject:location forKey:@"location"];
            //结束定位
            [[Location shareInstance] stopUpateLoaction];
            //更新定位
            [user updateInBackground];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"selfDeviceToken"]) {
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"selfDeviceToken"];
                [[BmobUserManager currentUserManager] checkAndBindDeviceToken:data];
            }
        }
        if (block) {
            block(user,error);
        }
    }];
}


/**
 *  注册
 *
 *  @param account  账号（手机号码）
 *  @param password 密码
 *  @param nickname 昵称
 *  @param schoolId 学校ID
 *  @param sex      性别
 *  @param age      年龄
 *  @param mobile   手机号码
 *  @param userIcon 用户头像
 *  @param block    注册结果
 */
+ (void)YDRegisterWithAccount:(NSString *)account Password:(NSString *)password NickName:(NSString *)nickname SchoolName:(NSString *)schoolName Sex:(NSString *)sex Age:(NSString *)age Mobile:(NSString *)mobile UserIcon:(NSString *)userIcon Filename:(NSString *)filename Blcok:(BmobBooleanResultBlock)block {
    
    BmobUser *user = [[BmobUser alloc] init];
    [user setUserName:account];
    [user setPassword:password];
    [user setObject:@"ios" forKey:@"deviceType"];
    [user setObject:nickname forKey:@"nickname"];
    [user setObject:schoolName forKey:@"schoolName"];
    [user setObject:sex forKey:@"sex"];
    [user setObject:age forKey:@"age"];
    [user setObject:mobile forKey:@"mobile"];
    [user setObject:filename forKey:@"filename"];
    [user setObject:userIcon forKey:@"iconUrl"];

    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"selfDeviceToken"]) {
        NSData *data         = [[NSUserDefaults standardUserDefaults] objectForKey:@"selfDeviceToken"];
        NSString *dataString = [NSString stringWithFormat:@"%@",data];
        dataString           = [dataString stringByReplacingOccurrencesOfString:@"<" withString:@""];
        dataString           = [dataString stringByReplacingOccurrencesOfString:@">" withString:@""];
        dataString           = [dataString stringByReplacingOccurrencesOfString:@" " withString:@""];
        [user setObject:dataString forKey:@"installId"];
        [[BmobUserManager currentUserManager] bindDeviceToken:data];
    }
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [self YDLoginWithMobile:mobile Password:password Block:^(BmobUser *user, NSError *error) {
                
            }];
        }
        if (block) {
            block(isSuccessful,error);
        }
    }];
}

/**
 *  查询用户是否已注册
 *
 *  @param mobile 手机号码
 *  @param block  结果
 */
+ (void)YDqueryWithMobile:(NSString *)mobile block:(BmobObjectArrayResultBlock)block {
    BmobQuery *query = [BmobUser query]; // 查询用户表
    [query whereKey:@"username" equalTo:mobile];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (block) {
            block(array,error);
        }
    }];

}

/**
 *  是否需要弹出登陆框
 *
 *  @param viewController 当前viewcontroller
 *  @param animated       是否需要动画
 */
+(void)needLoginWithViewController:(UIViewController*)viewController animated:(BOOL)animated {
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] boolValue]) {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        UINavigationController *lnc= [[UINavigationController alloc] initWithRootViewController:lvc];
        lnc.navigationBarHidden = YES;
        [viewController presentViewController:lnc animated:animated completion:^{
            
        }];
    }
}

@end
