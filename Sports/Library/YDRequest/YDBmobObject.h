//
//  YDBmobObject.h
//  Sports
//
//  Created by 吴超 on 15/7/6.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/BmobObject.h>
@interface YDBmobObject : NSObject
/**
 *  发布信息
 *
 *  @param typeId     运动类型
 *  @param schoolName 学校名称
 *  @param site       具体地点
 *  @param timer      时间
 *  @param peopleNum  人数
 *  @param content    说明
 *  @param block      回调
 */
+ (void)YDSaveWithTypeID:(NSString *)typeName SchoolName:(NSString *)schoolName Site:(NSString *)site Timer:(NSString *)timer PeopleNum:(NSString *)peopleNum Content:(NSString *)content Block:(BmobBooleanResultBlock)block;
@end
