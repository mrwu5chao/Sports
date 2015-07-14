//
//  LoginViewController.m
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "YDBmobUser.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    
    __weak IBOutlet UIView *_mainView;
    __weak IBOutlet UITextField *_mobileText;
    __weak IBOutlet UITextField *_passwordText;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Click
// 登录
- (IBAction)loginPresson:(id)sender {
    [self resignFirstResponder];
    
    [[AppDelegate defaultAppDelegate] showLoading:@"正在登录..."];
     __weak typeof(self) weakSelf = self;
    [YDBmobUser YDLoginWithMobile:_mobileText.text Password:_passwordText.text Block:^(BmobUser *user, NSError *error) {
        [[AppDelegate defaultAppDelegate] hiddenLoading];
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AppDelegate defaultAppDelegate] showHint:@"登录失败，请重试" Timer:2];
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf dismissSelf];
            });            
        }
    }];
}

// 立即加入
- (IBAction)joinPresson:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

// 忘记密码
- (IBAction)forgotPwPresson:(id)sender {
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

-(void)dismissSelf{
    [[NSUserDefaults standardUserDefaults ] setObject:[NSNumber numberWithBool:NO] forKey:@"isLogin"];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self resignFirstResponder];
    return YES;
}
@end
