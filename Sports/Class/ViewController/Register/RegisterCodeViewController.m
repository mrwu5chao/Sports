//
//  RegisterCodeViewController.m
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "RegisterCodeViewController.h"
#import "RegisterPwViewController.h"

#import <SMS_SDK/SMS_SDK.h>

@interface RegisterCodeViewController ()
{
    __block int _timeout;
    dispatch_source_t _timer;
    __weak IBOutlet UIView *_mainView;
    __weak IBOutlet UIButton *_codeBtn;
    __weak IBOutlet UITextField *_codeText;
    __weak IBOutlet UILabel *_codeLabel;
}
@end

@implementation RegisterCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationTopBar.titleLabel setText:@"填写验证码"];
    [_mainView setFrame:CGRectMake(0, self.navigationTopBar.bottom, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.navigationTopBar.bottom)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Click
- (IBAction)againPresson:(id)sender {
    [[AppDelegate defaultAppDelegate] showLoading:nil];
    [SMS_SDK getVerificationCodeBySMSWithPhone:self.mobileStr zone:@"86" result:^(SMS_SDKError *error) {
        [[AppDelegate defaultAppDelegate] hiddenLoading];
        if (!error) {
            [self startTimerCountDown];
//            [[AppDelegate defaultAppDelegate] showHint:@"验证码已发送" Timer:1.5];
            [MBProgressHUD showSuccess:@"验证码已发送" toView:self.view];
            
        } else {
            [self stopTimer];
//            [[AppDelegate defaultAppDelegate] showHint:@"验证码发送失败" Timer:1.5];
            [MBProgressHUD showError:@"验证码发送失败" toView:self.view];
        }
    }];

}

- (void)leftPresson {
    [self stopTimer];
}

- (IBAction)nextPresson:(id)sender {
    [SMS_SDK commitVerifyCode:_codeText.text result:^(enum SMS_ResponseState state) {
        [self stopTimer];
        if (state == 1) {
            RegisterPwViewController *registerPwVC = [[RegisterPwViewController alloc] init];
            [registerPwVC setMobileStr:_mobileStr];
            [self.navigationController pushViewController:registerPwVC animated:YES];
        } else {
            [[AppDelegate defaultAppDelegate] showHint:@"验证码不正确" Timer:1.5];
        }
    }];
    
//    RegisterPwViewController *registerPwVC = [[RegisterPwViewController alloc] init];
//    [self.navigationController pushViewController:registerPwVC animated:YES];

}

//验证码倒计时操作
- (void)startTimerCountDown
{
    _timeout = 60;   //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        
        if (_timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_codeLabel setText:@"重新获取"];
                _codeBtn.userInteractionEnabled = YES;
            });
        }
        else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_codeLabel setText:[NSString stringWithFormat:@"%ds后重新发送",_timeout]];
                _codeBtn.userInteractionEnabled = NO;
            });
            _timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

//检测timer，取消其有效性
- (void)stopTimer
{
    if (_timeout > 0) { //倒计时结束，关闭
        dispatch_source_cancel(_timer);
        //dispatch_release(_timer);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_codeLabel setText:@"重新获取"];
            _codeBtn.userInteractionEnabled = YES;
        });
    }
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
