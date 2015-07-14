//
//  BaseViewController.h
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//
/*
 * 作者: 吴超
 * 功能说明:
 * 1.第一次启动展示页
 */
#import <UIKit/UIKit.h>
@protocol AppIntroduceDelegate<NSObject>
- (void)goToHomeController;
@end
@interface UserIntroView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}

@property (retain, nonatomic) UIButton *skipBtn;
@property (nonatomic,assign)id<AppIntroduceDelegate>delegate;
+ (void)showWhileVersionChange;
@end
