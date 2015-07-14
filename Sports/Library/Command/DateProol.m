//
//  DateProol.m
//  Sports
//
//  Created by 吴超 on 15/7/3.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "DateProol.h"

@implementation DateProol
// 计算出生日期与当前日期的差 得到具体年龄
+ (float)calculateAgeFromDate:(NSDate *)date1 toDate:(NSDate *)date2{
    
    
    NSCalendar *userCalendar = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit;
    
    NSDateComponents *components = [userCalendar components:unitFlags fromDate:date1 toDate:date2 options:0];
    
    float years = [components year];
    
    return years;
    
}

@end
