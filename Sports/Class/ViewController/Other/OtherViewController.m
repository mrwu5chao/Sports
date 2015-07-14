//
//  OtherViewController.m
//  Sports
//
//  Created by 吴超 on 15/7/6.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "OtherViewController.h"
#import "IndexTableView.h"

@interface OtherViewController ()<UITableViewDelegate,UITableViewEventDelegate,UITableViewDataSource>
{
    UIView *_mainView;
    IndexTableView *_tableView;

}
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:UIColorFromRGB(230, 230, 230)];
    [self.navigationTopBar.titleLabel setText:self.title];
    
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationTopBar.bottom, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.navigationTopBar.bottom)];
    [_mainView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_mainView];
    [self creatBaseView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatBaseView {
    
    NSArray *array = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    
    _tableView=[[IndexTableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, _mainView.height) style:
                UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.eventdelegate=self;
    [_tableView setData:array];
    [_mainView addSubview:_tableView];
    
}
#pragma mark -Click
- (void)leftPresson {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -UITableViewEventDelegate
- (void)pullDown:(BaseTableView *)tableview {
    
}

- (void)pullUp:(BaseTableView *)tableview {
    
}

- (void)tableView:(BaseTableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
