//
//  YDCache.m
//  Sports
//
//  Created by 吴超 on 15/7/5.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "YDCache.h"

@implementation YDCache
+ (NSString *)indexFilePath {
    // 获取indexData.plist位置文件的路径
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSString *indexFilePath = [documentsDirectory stringByAppendingPathComponent:@"University.plist"];
    return indexFilePath;
}

// 首页数据
+ (NSArray *)getIndexDictData {
    NSString *indexFilePath = [YDCache indexFilePath];
    
    NSDictionary *indexDic = [NSDictionary dictionaryWithContentsOfFile:indexFilePath];
    
    NSArray *indexArray = nil;
    
    if ([indexDic isKindOfClass:[NSDictionary class]]) {
        
        indexArray = [indexDic objectForKey:@"indexArray"];
        if ([indexArray isKindOfClass:[NSArray class]] == NO) {
            indexArray = nil;
        }
    }
    return indexArray;
    
}
// 保存首页数据
+ (void)saveIndexDataWithIndexArray:(NSArray *)indexArray {
    if ([indexArray isKindOfClass:[NSArray class]]) {
        NSDictionary *indexDic = [NSDictionary dictionaryWithObjectsAndKeys:indexArray, @"indexArray",nil];
        NSString *indexFilePath = [self indexFilePath];
        [indexDic writeToFile:indexFilePath atomically:YES];
    }
}

@end
