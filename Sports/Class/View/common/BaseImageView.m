//
//  BaseImageView.m
//  Sports
//
//  Created by 吴超 on 15/7/6.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "BaseImageView.h"

@implementation BaseImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer*)tap{
    if (self.touchBlock) {
        _touchBlock();
    }
}


@end
