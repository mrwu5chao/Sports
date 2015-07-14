//
//  UniversityViewController.h
//  Sports
//
//  Created by 吴超 on 15/7/3.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "YDBaseViewController.h"
typedef void (^SchoolName)(NSString *);
@interface UniversityViewController : YDBaseViewController
@property(nonatomic,copy)SchoolName selectSchool;

@end
