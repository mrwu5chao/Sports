//
//  LoginViewController.h
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "UIImage+ResizeImage.h"

@implementation UIImage (ResizeImage)
+(UIImage*)reDrawImage:(UIImage *)souceImage rect:(CGRect)souceRect
{
    UIImage* image = souceImage;
    CGRect rect = souceRect;
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height * 0.6;
    
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeStretch];
}

@end
