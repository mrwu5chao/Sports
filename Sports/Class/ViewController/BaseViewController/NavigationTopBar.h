//
//  NavigationTopBar.h
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//
/*
 * 作者: 吴超
 * 功能说明:
 * 1.自定义导航栏，系统UI兼容
 */

#import <UIKit/UIKit.h>
@interface NavigationSubView : UIView

@end

@interface NavigationTopBar : UIView

@property (nonatomic, assign, getter = isHidden) BOOL hidden;

@property (nonatomic, readonly) UIView *statusBar;          // 电池栏，背景色默认为
@property (nonatomic, readonly) NavigationSubView *navigationBar;
@property (nonatomic, readonly) UIButton *leftButton;
@property (nonatomic, readonly) UIButton *rightButton;
@property (nonatomic, readonly) UILabel *titleLabel;
@end
