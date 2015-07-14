//
//  UIView+ViewFrameGeometry.h
//  HuiHenDuo
//
//  Created by Poison on 14-3-17.
//  Copyright (c) 2014年 HuiHenDuo. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, readonly) CGPoint bottomLeft;
@property (nonatomic, readonly) CGPoint bottomRight;
@property (nonatomic, readonly) CGPoint topRight;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

- (void)moveBy:(CGPoint)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInSize:(CGSize)aSize;

@end
