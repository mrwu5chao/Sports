//
//  UIView+Addition.h
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)
-(UIViewController *)viewcontroller{
    UIResponder *next = [self nextResponder];  //取得下一个响应者
    //循环判断
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next!=nil);
    return nil;
}
@end
