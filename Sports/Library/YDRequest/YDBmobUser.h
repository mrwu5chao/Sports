//
//  YDBmobUser.h
//  Sports
//
//  Created by 吴超 on 15/6/30.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>
@interface YDBmobUser : NSObject
/**
 *  用户登录
 *
 *  @param mobile   用于账号（手机号码）
 *  @param password 密码
 *  @param block    结果
 */
+ (void)YDLoginWithMobile:(NSString *)mobile Password:(NSString *)password Block:(BmobUserResultBlock)block;


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
+ (void)YDRegisterWithAccount:(NSString *)account Password:(NSString *)password NickName:(NSString *)nickname SchoolName:(NSString *)schoolName Sex:(NSString *)sex Age:(NSString *)age Mobile:(NSString *)mobile UserIcon:(NSString *)userIcon Filename:(NSString *)filename Blcok:(BmobBooleanResultBlock)block;

/**
 *  查询用户是否已注册
 *
 *  @param mobile 手机号码
 *  @param block  结果
 */
+ (void)YDqueryWithMobile:(NSString *)mobile block:(BmobObjectArrayResultBlock)block;

/**
 *  是否需要弹出登陆框
 *
 *  @param viewController 当前viewcontroller
 *  @param animated       是否需要动画
 */
+(void)needLoginWithViewController:(UIViewController*)viewController animated:(BOOL)animated;
@end
