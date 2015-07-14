//
//  LeftMenuViewController.m
//  Sports
//
//  Created by 吴超 on 15/6/29.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SettingViewController.h"
#import "LeftTableViewCell.h"
#import "OtherViewController.h"

@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    __weak IBOutlet UIView *_mainView;
    __weak IBOutlet UITableView *_tableView;
    IBOutlet UITableViewCell *_userCell;
    NSMutableArray *_leftArray;
}
@end

@implementation LeftMenuViewController

- (MFSideMenuContainerViewController *)menuContainerViewController {
    return (MFSideMenuContainerViewController *)self.parentViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationTopBar setHidden:YES];
    
    _leftArray = [[NSMutableArray alloc] initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"消息",@"title",[UIImage imageNamed:@"tones-50"],@"image",nil],[NSDictionary dictionaryWithObjectsAndKeys:@"我发起的",@"title",[UIImage imageNamed:@"left_groups-50"],@"image",nil],[NSDictionary dictionaryWithObjectsAndKeys:@"我报名的",@"title",[UIImage imageNamed:@"checklist-50"],@"image",nil],[NSDictionary dictionaryWithObjectsAndKeys:@"我参与的",@"title",[UIImage imageNamed:@"inspection-50"],@"image",nil],[NSDictionary dictionaryWithObjectsAndKeys:@"我收藏的",@"title",[UIImage imageNamed:@"like-50"],@"image",nil], nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingPresson:(id)sender {
    SettingViewController *settingController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:settingController];
    [self presentViewController:navigationController animated:YES completion:nil];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return _leftArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return _userCell;
    }
    static NSString *identify = @"LeftTableViewCell";
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identify owner:nil options:nil] firstObject];
        UIView *selectView = [[UIView alloc] initWithFrame:cell.frame];
        [selectView setBackgroundColor:UIColorFromRGB(194, 201, 207)];
        [cell setSelectedBackgroundView:selectView];
    }
    NSDictionary *dict = [_leftArray objectAtIndex:indexPath.row];
    [cell.leftImageView setImage:[dict objectForKey:@"image"]];
    [cell.leftLabel setText:[dict objectForKey:@"title"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 130;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 个人中心
        }

    } else {
        if (indexPath.row == 0) {
            // 消息
        } else {
            OtherViewController *otherVC = [[OtherViewController alloc] init];
            [otherVC setTitle:[[_leftArray objectAtIndex:indexPath.row] objectForKey:@"title"]];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:otherVC];
            [self presentViewController:navigationController animated:YES completion:nil];
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

        }
    }
}

@end
