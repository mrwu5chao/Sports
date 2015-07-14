//
//  YDDatePicker.h
//  Sports
//
//  Created by 吴超 on 15/7/5.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol YDDatePickerDelegate <NSObject>

-(void)YDDatePickerDidConfirm:(NSString *)confirmString;

@end

@interface YDDatePicker : NSObject

@property (nonatomic,weak) id <YDDatePickerDelegate> delegate;

//是否可选择今天以前的时间,默认为YES
@property (nonatomic,assign) BOOL isBeforeTime;

//datePicker显示类别,分别为1=只显示时间,2=只显示日期，3=显示日期和时间(默认为3)
@property (nonatomic,assign) NSInteger theTypeOfDatePicker;

-(id)initWithSelectViewOfDelegate:(UIView *)view delegate:(id<YDDatePickerDelegate>)delegate;

//出现
-(void)pushDatePicker;
//消失
-(void)popDatePicker;

@end
