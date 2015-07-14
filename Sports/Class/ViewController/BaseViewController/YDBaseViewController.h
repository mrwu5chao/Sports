//
//  YDBaseViewController.h
//  Sports
//
//  Created by 吴超 on 15/7/9.
//  Copyright (c) 2015年 吴超. All rights reserved.
//
/*
 * 作者: 吴超
 * 功能说明:
 * 1.所有页面的父类
 */

#import <UIKit/UIKit.h>
#import "NavigationTopBar.h"

@interface YDBaseViewController : UIViewController
@property (nonatomic, strong) NavigationTopBar *navigationTopBar;
- (void)leftPresson;
- (void)rightPresson;

@end
