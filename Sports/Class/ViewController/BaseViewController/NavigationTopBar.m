//
//  NavigationTopBar.m
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "NavigationTopBar.h"

@implementation NavigationSubView

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    
    [self.superview setHidden:hidden];
}

@end

@interface NavigationTopBar ()

@end

@implementation NavigationTopBar

- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, IS_iOS7 ? 0 : -20, UI_SCREEN_WIDTH, 64)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)dealloc
{
    _statusBar = nil;
    _navigationBar = nil;
    _titleLabel = nil;
    _leftButton = nil;
    _rightButton = nil;
}

- (void)createView {
    
    _navigationBar = [[NavigationSubView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [_navigationBar setUserInteractionEnabled:YES];
    [_navigationBar setBackgroundColor:UIColorFromRGB(32, 90, 132)];
    [self addSubview:_navigationBar];
    _navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    _navigationBar.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _navigationBar.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    _navigationBar.layer.shadowRadius = 4;//阴影半径，默认3

    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setFrame:CGRectMake(0, 20, 44, 44)];
    [_leftButton setBackgroundColor:[UIColor clearColor]];
    [_leftButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [_leftButton setImage:[UIImage imageNamed:@"bar_back_white"] forState:UIControlStateNormal];
    [_navigationBar addSubview:_leftButton];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(UI_SCREEN_WIDTH - 44, 20, 44, 44)];
    [_rightButton setBackgroundColor:[UIColor clearColor]];
    [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [_navigationBar addSubview:_rightButton];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 180, 44)];
    [_titleLabel setBackgroundColor:[UIColor clearColor]];
    [_titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_navigationBar addSubview:_titleLabel];
    

}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:NO];
    
    _hidden = hidden;
    
    if (_navigationBar.hidden != _hidden) {
        [_navigationBar setHidden:_hidden];
    }
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _hidden ? 0 : 64)];
}


#pragma mark - View Frame Geometry
- (CGFloat)height {
    if (_hidden || _navigationBar.hidden) {
        return 0;
    }
    return 64;
}

- (CGFloat)bottom {
    CGFloat bottom = 0.0f;
    if (IS_iOS7) {
        bottom += 20.0f;
    }
    if (_hidden == NO && _navigationBar.hidden == NO) {
        bottom += 44.0f;
    }
    return bottom;
}

- (CGSize)size {
    return CGSizeMake(UI_SCREEN_WIDTH, [self height]);
}

@end
