//
//  PengActionSheet.h
//  Peng
//
//  Created by huihenduo on 14-9-30.
//  Copyright (c) 2014年 wuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PengActionSheet;
@protocol PengActionSheetDelegate <NSObject>
- (void)didClickOnButtonIndex:(NSInteger )buttonIndex inActionSheet:(PengActionSheet*)actionSheet;
@optional
- (void)didClickOnDestructiveButton;
- (void)didClickOnCancelButton;
@end

@interface PengActionSheet : UIActionSheet

@property(strong,nonatomic)UIDatePicker*datePicker;

- (id)initWithTitle:(NSString *)title delegate:(id<PengActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles,...NS_REQUIRES_NIL_TERMINATION;

- (void)showInView:(UIView *)view;

-(void)actionSheetAddDatePicker;

@end
