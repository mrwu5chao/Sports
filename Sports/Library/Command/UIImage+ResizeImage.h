//
//  LoginViewController.h
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizeImage)

+(UIImage*)reDrawImage:(UIImage *)souceImage rect:(CGRect)souceRect;

+ (UIImage *)resizeImage:(NSString *)imageName;

@end
