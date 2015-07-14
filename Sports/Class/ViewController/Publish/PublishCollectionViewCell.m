//
//  PublishCollectionViewCell.m
//  Sports
//
//  Created by 吴超 on 15/7/5.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "PublishCollectionViewCell.h"

@implementation PublishCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.bigImagebton=[[UIButton alloc]initWithFrame:CGRectMake(0, 5, 53, 53)];
        [self.bigImagebton setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.bigImagebton];
        
        self.selcetImageView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 40, 17, 17)];
        self.selcetImageView.hidden = YES;
        [self addSubview:self.selcetImageView];
                
    }
    return self;
}

@end
