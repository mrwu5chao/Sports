//
//  YDBmobObject.m
//  Sports
//
//  Created by 吴超 on 15/7/6.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "YDBmobObject.h"
#import <BmobSDK/BmobUser.h>
@implementation YDBmobObject
/**
 *  发布信息
 *
 *  @param typeId     运动类型
 *  @param schoolName 学校名称
 *  @param site       具体地点
 *  @param timer      时间
 *  @param propleNum  人数
 *  @param content    说明
 *  @param block      回调
 */
+ (void)YDSaveWithTypeID:(NSString *)typeName SchoolName:(NSString *)schoolName Site:(NSString *)site Timer:(NSString *)timer PeopleNum:(NSString *)peopleNum Content:(NSString *)content Block:(BmobBooleanResultBlock)block {
    BmobObject *pushObject = [BmobObject objectWithClassName:@"ActivityFees"];
    [pushObject setObject:content forKey:@"content"];  //说明
    [pushObject setObject:typeName forKey:@"typeName"];     //类型
    [pushObject setObject:schoolName forKey:@"schoolName"];   //学校
    [pushObject setObject:site forKey:@"site"];     //地点
    [pushObject setObject:peopleNum forKey:@"people"];     //人数
    [pushObject setObject:timer forKey:@"time"];     //时间
    
    // 设置发布的作者
    BmobObject *author = [BmobObject objectWithoutDatatWithClassName:@"_User" objectId:[[BmobUser getCurrentUser] objectId]];
    [pushObject setObject:author forKey:@"author"];
    
    [pushObject saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        block(isSuccessful,error);
    }];
}

@end
