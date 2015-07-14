//
//  RegisterPwViewController.m
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "RegisterPwViewController.h"
#import "RegisterIconViewController.h"

@interface RegisterPwViewController ()
{
    
    __weak IBOutlet UIView *_mainView;
    __weak IBOutlet UITextField *_passwordText;
    __weak IBOutlet UITextField *_againPwText;
}
@end

@implementation RegisterPwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationTopBar.titleLabel setText:@"填写密码"];
    [_mainView setFrame:CGRectMake(0, self.navigationTopBar.bottom, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.navigationTopBar.bottom)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Click
- (IBAction)nextPresson:(id)sender {
    if ([_passwordText.text length] == 0 || [_againPwText.text length] == 0) {
        [[AppDelegate defaultAppDelegate] showHint:@"请输入密码" Timer:1.5];
        return;
    }
    if ([_passwordText.text length] < 6) {
        [[AppDelegate defaultAppDelegate] showHint:@"密码最低为6位" Timer:1.5];
        return;
    }
    if (![_passwordText.text isEqualToString:_againPwText.text]) {
        [[AppDelegate defaultAppDelegate] showHint:@"两次密码输入不正确，请重新输入" Timer:1.5];
        return;
    }
    
    RegisterIconViewController *registerIcon = [[RegisterIconViewController alloc] init];
    [registerIcon setMobileStr:_mobileStr];
    [registerIcon setPasswordStr:_passwordText.text];
    [self.navigationController pushViewController:registerIcon animated:YES];
    
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
