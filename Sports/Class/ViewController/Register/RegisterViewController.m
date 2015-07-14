//
//  RegisterViewController.m
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterCodeViewController.h"
#import "YDBmobUser.h"
#import <SMS_SDK/SMS_SDK.h>

@interface RegisterViewController ()
{
    
    __weak IBOutlet UIView *_mainView;
    __weak IBOutlet UITextField *_mobileText;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationTopBar.titleLabel setText:@"填写手机号码"];
    [_mainView setFrame:CGRectMake(0, self.navigationTopBar.bottom, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.navigationTopBar.bottom)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -Click
- (IBAction)nextPresson:(id)sender {
    if ([_mobileText.text length]<11) {
        [[AppDelegate defaultAppDelegate] showHint:@"请输入正确手机号码" Timer:1.5];
        return;
    } else {
        [[AppDelegate defaultAppDelegate] showLoading:nil];
        [YDBmobUser YDqueryWithMobile:_mobileText.text block:^(NSArray *array, NSError *error) {
            if ([array count] == 0) {
                [SMS_SDK getVerificationCodeBySMSWithPhone:_mobileText.text zone:@"86" result:^(SMS_SDKError *error) {
                    [[AppDelegate defaultAppDelegate] hiddenLoading];
                    if (!error) {
                        RegisterCodeViewController *registerCode = [[RegisterCodeViewController alloc] init];
                        [registerCode setMobileStr:_mobileText.text];
                        [self.navigationController pushViewController:registerCode animated:YES];

                    } else {
                        [MBProgressHUD showError:@"验证码发送失败" toView:self.view];
                    }
                }];
            } else {
                [[AppDelegate defaultAppDelegate] hiddenLoading];
                [[AppDelegate defaultAppDelegate] showHint:@"该手机号码已注册" Timer:1.5];
            }
        }];
    }
    
//    RegisterCodeViewController *registerCode = [[RegisterCodeViewController alloc] init];
//    [self.navigationController pushViewController:registerCode animated:YES];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view || touch.view == _mainView) {
        [self resignFirstResponder];
    }
}
- (BOOL)resignFirstResponder {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES]; //关闭键盘
    return [super resignFirstResponder];
}



@end
