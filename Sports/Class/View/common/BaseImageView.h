//
//  BaseImageView.h
//  Sports
//
//  Created by 吴超 on 15/7/6.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ImageBlock)(void);
@interface BaseImageView : UIImageView
@property(nonatomic,copy)ImageBlock touchBlock;

@end
