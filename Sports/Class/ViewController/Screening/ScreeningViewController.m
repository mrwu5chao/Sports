//
//  ScreeningViewController.m
//  Sports
//
//  Created by 吴超 on 15/7/9.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "ScreeningViewController.h"

@interface ScreeningViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_screeningArray;
    NSArray *_sectionArray;
    NSIndexPath *_indexPath;
    NSDictionary *_indexPathDict;
}
@end

@implementation ScreeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:UIColorFromRGB(230, 230, 230)];
    [self.navigationTopBar.titleLabel setText:@"筛选"];
    [self.navigationTopBar.rightButton setImage:[UIImage imageNamed:@"good_quality-50"] forState:UIControlStateNormal];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigationTopBar.bottom, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -self.navigationTopBar.bottom) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
    
    _sectionArray = [[NSArray alloc] initWithObjects:@"运动类型",@"运动时间",@"是否认证", nil];
    _screeningArray = [[NSArray alloc] initWithObjects:[NSArray arrayWithObjects:@"不限",@"跑步",@"篮球",@"足球", nil],[NSArray arrayWithObjects:@"不限",@"今天",@"明天",@"一周内", nil],[NSArray arrayWithObjects:@"不限",@"已认证",@"未认证", nil], nil];
    _indexPathDict = [NSDictionary dictionary];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    _indexPathDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"indexPathDict"];
    if (![_indexPathDict isKindOfClass:[NSDictionary class]]) {
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    } else {
        if ([[_indexPathDict objectForKey:@"section"] integerValue] == indexPath.section && [[_indexPathDict objectForKey:@"row"] integerValue] == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else if ([[_indexPathDict objectForKey:@"section"] integerValue] == indexPath.section && [[_indexPathDict objectForKey:@"row"] integerValue] != indexPath.row){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    NSArray *array = [_screeningArray objectAtIndex:indexPath.section];
    [cell.textLabel setText:[array objectAtIndex:indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 40)];
    [label setText:[NSString stringWithFormat:@"   %@",[_sectionArray objectAtIndex:section]]];
    [label setBackgroundColor:UIColorFromRGB(230, 230, 230)];
    return label;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_screeningArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _indexPathDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",indexPath.section],@"section",[NSString stringWithFormat:@"%ld",indexPath.row],@"row", nil];
    [[NSUserDefaults standardUserDefaults] setObject:_indexPathDict forKey:@"indexPathDict"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_tableView reloadData];
    
}

@end
