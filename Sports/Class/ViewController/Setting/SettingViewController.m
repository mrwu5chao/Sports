//
//  SettingViewController.m
//  Sports
//
//  Created by 吴超 on 15/7/1.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "SettingViewController.h"
#import "YDBmobUser.h"
#import <BmobSDK/BmobUser.h>
@interface SettingViewController ()
{
    
    __weak IBOutlet UIView *_mainView;
    IBOutlet UITableViewCell *_loginOutCell;

    __weak IBOutlet UITableView *_settingTable;
    NSArray *_titleArray;
    NSArray *_imageArray;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationTopBar.titleLabel setText:@"设置"];
    [_mainView setFrame:CGRectMake(0, self.navigationTopBar.bottom, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -self.navigationTopBar.bottom)];

    
    
}

- (void)viewDidLayoutSubviews {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Click
- (void)leftPresson {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  退出登录
 *
 *  @param sender sender
 */
- (IBAction)loginOutPresson:(id)sender {
    [BmobUser logout];
    [[NSUserDefaults standardUserDefaults ] setObject:[NSNumber numberWithBool:NO] forKey:@"isLogin"];
    [YDBmobUser needLoginWithViewController:self animated:YES];

}

/**
 *  关于我们
 *
 *  @param sender sender
 */
- (IBAction)aboutUsPresson:(id)sender {
    
}

/**
 *  给个好评
 *
 *  @param sender sender
 */
- (IBAction)praisePresson:(id)sender {
    
}

/**
 *  意见反馈
 *
 *  @param sender sender
 */
- (IBAction)feedbackPresson:(id)sender {
    
}

/**
 *  邀请好友
 *
 *  @param sender sender
 */
- (IBAction)invitationPresson:(id)sender {
    
}

/**
 *  更换手机号码
 *
 *  @param sender sender
 */
- (IBAction)changeMobilePresson:(id)sender {
    
}

/**
 *  修改密码
 *
 *  @param sender sender
 */
- (IBAction)changePwPresson:(id)sender {
    
}

@end
