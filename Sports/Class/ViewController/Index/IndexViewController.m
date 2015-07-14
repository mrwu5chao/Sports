//
//  IndexViewController.m
//  Sports
//
//  Created by 吴超 on 15/6/29.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "IndexViewController.h"
#import <BmobSDK/BmobUser.h>
#import "YDBmobUser.h"
#import "PublishViewController.h"
#import "IndexTableView.h"
#import "ScreeningViewController.h"

@interface IndexViewController ()<UITableViewDelegate,UITableViewEventDelegate,UITableViewDataSource,IChatManagerDelegate>
{
    UIView *_mainView;
    IndexTableView *_tableView;
}
@end

@implementation IndexViewController

- (MFSideMenuContainerViewController *)menuContainerViewController {
    return (MFSideMenuContainerViewController *)self.navigationController.parentViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:UIColorFromRGB(230, 230, 230)];
    [self.navigationTopBar.titleLabel setText:@"动态"];
    [self.navigationTopBar.leftButton setImage:[UIImage imageNamed:@"menu-left"] forState:UIControlStateNormal];
    [self.navigationTopBar.rightButton setImage:[UIImage imageNamed:@"menu-right"] forState:UIControlStateNormal];
    
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationTopBar.bottom, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.navigationTopBar.bottom)];
    [_mainView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_mainView];
    
    
    BmobUser *user = [BmobUser getCurrentUser];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"ActivityFees"];
    [bquery whereKey:@"schoolName" equalTo:[user objectForKey:@"schoolName"]];
    //声明该次查询需要将author关联对象信息一并查询出来
    [bquery includeKey:@"author"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            NSLog(@"array  %@",array);
            for (BmobObject *post in array) {
                NSLog(@"%@",[post objectForKey:@"title"]);
            }
        }
    }];
    
    [self creatBaseView];

}

- (void)creatBaseView {
    // 发布按钮
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setFrame:CGRectMake(UI_SCREEN_WIDTH - 80, UI_SCREEN_HEIGHT - 80, 72, 72)];
    [publishBtn setImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishPresson) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishBtn];
    [self.view bringSubviewToFront:publishBtn];

    NSArray *array = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    
    _tableView=[[IndexTableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, _mainView.height) style:
             UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.eventdelegate=self;
    [_tableView setData:array];
    [_mainView addSubview:_tableView];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BmobUser *user = [BmobUser getCurrentUser];
    if (!user) {
        [YDBmobUser needLoginWithViewController:self animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -Click
- (void)leftPresson {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];

}

// 筛选
- (void)rightPresson {
    ScreeningViewController *screeningVC = [[ScreeningViewController alloc] init];
    [self.navigationController pushViewController:screeningVC animated:YES];
}

// 发布
- (void)publishPresson {
    PublishViewController *publishVC = [[PublishViewController alloc] init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

#pragma mark -UITableViewEventDelegate
- (void)pullDown:(BaseTableView *)tableview {
    
}

- (void)pullUp:(BaseTableView *)tableview {
    
}

- (void)tableView:(BaseTableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
