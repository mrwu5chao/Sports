//
//  YDCache.h
//  Sports
//
//  Created by 吴超 on 15/7/5.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDCache : NSObject
// 首页数据
+ (NSArray *)getIndexDictData;
// 保存首页数据
+ (void)saveIndexDataWithIndexArray:(NSArray *)indexArray;

@end
