//
//  UniversityViewController.m
//  Sports
//
//  Created by 吴超 on 15/7/3.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "UniversityViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <BmobSDK/BmobQuery.h>
#import "Location.h"
#import "YDCache.h"

@interface UniversityViewController ()<BMKPoiSearchDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    
    __weak IBOutlet UIView *_mainView;
    
    __weak IBOutlet UISearchBar *_searchView;
    
    __weak IBOutlet UITableView *_tableView;
    BMKPoiSearch *_searcher;
    NSMutableArray *_schoolNameArray;
    NSMutableArray *_tipsArray;
    NSArray *_nameArray;
    NSMutableArray *_searchArray;
}
@end

@implementation UniversityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationTopBar.titleLabel setText:@"选择学校"];
    [_mainView setFrame:CGRectMake(0, self.navigationTopBar.bottom, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.navigationTopBar.bottom)];
    _schoolNameArray = [[NSMutableArray alloc] init];
    _tipsArray = [[NSMutableArray alloc] init];
    _nameArray = [[NSArray alloc] init];
    _searchArray = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 4; i++) {
        BmobQuery   *bquery = [BmobQuery queryWithClassName:@"University_fees"];
        [bquery setSkip:1000*(i-1)];
        [bquery setLimit:1000*i];
        bquery.cachePolicy = kBmobCachePolicyCacheElseNetwork;
        //查找GameScore表的数据
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {

        }];
 
    }
    
    [_tableView setTop:_searchView.bottom -20];
    [[AppDelegate defaultAppDelegate] showLoading:@"正在更新附近学校"];
    //初始化检索对象
    _searcher =[[BMKPoiSearch alloc]init];
    _searcher.delegate = self;
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 10;
    CLLocationCoordinate2D gpsCoor  = [[Location shareInstance] currentLocation];
    option.location = gpsCoor;
    option.keyword = @"学校";
    option.radius = 10000; // 检索范围 单位:m
    BOOL flag = [_searcher poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        [[AppDelegate defaultAppDelegate] hiddenLoading];
        [MBProgressHUD showError:@"更新失败" toView:self.view];
        [_tipsArray addObject:[NSDictionary dictionaryWithObject:@"name" forKey:@"暂时无法找到您附近的学校"]];
    }
    
    [self setExtraCellLineHidden:_tableView];

}

//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        for (int i = 0; i < poiResultList.poiInfoList.count; i++)
        {
            BMKPoiInfo* poi = [poiResultList.poiInfoList objectAtIndex:i];
            [_schoolNameArray addObject:poi.name];
        }
    }
    else {
        NSLog(@"抱歉，未找到结果");

    }
    NSLog(@"学校名称  %@",_schoolNameArray);
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"University_fees"];
    [bquery whereKey:@"name" containedIn:[_schoolNameArray copy]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [[AppDelegate defaultAppDelegate] hiddenLoading];
        if ([array count] > 0) {
            [MBProgressHUD showSuccess:@"更新完成" toView:self.view];
            _nameArray = array;
        } else {
            [MBProgressHUD showError:@"更新失败" toView:self.view];
            [_tipsArray addObject:[NSDictionary dictionaryWithObject:@"暂时无法找到您附近的学校" forKey:@"name"]];
        }
        [_tableView reloadData];
    }];
}
- (void)setExtraCellLineHidden: (UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark -UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self handleSearchForTerm:searchText];
}
-(void)handleSearchForTerm:(NSString *)searchTerm {
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"University_fees"];
    [bquery whereKey:@"name" matchesWithRegex:searchTerm];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if ([array count] > 0) {
            _searchArray = [array copy];
            [_tableView reloadData];
        } else {
            [_tipsArray addObject:[NSDictionary dictionaryWithObject:@"暂无您的学校" forKey:@"name"]];
        }
        
    }];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    if ([_searchArray count] > 0) {
//        [_searchArray removeAllObjects];
//    }
    NSString *searchText = searchBar.text;
    [self handleSearchForTerm:searchText];
}

#pragma mark -UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (tableView == _tableView) {
        if (_nameArray.count > 0) {
            BmobObject *dict = [_nameArray objectAtIndex:indexPath.row];
            [cell.textLabel setText:[dict objectForKey:@"name"]];
        } else {
            [cell.textLabel setText:[[_tipsArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
        }
    } else {
        if (_searchArray.count > 0) {
            BmobObject *dict = [_searchArray objectAtIndex:indexPath.row];
            [cell.textLabel setText:[dict objectForKey:@"name"]];
        } else {
            [cell.textLabel setText:[[_tipsArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
        }

    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView) {
        if (_nameArray.count > 0) {
            return _nameArray.count;
        }
        return _tipsArray.count;

    } else {
        if (_searchArray.count > 0) {
            return _searchArray.count;
        }
        return _tipsArray.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, UI_SCREEN_WIDTH, 20)];
    [headLabel setText:@"   附近的学校"];
    [headLabel setBackgroundColor:UIColorFromRGB(239, 245, 249)];
    [headLabel setTextColor:UIColorFromRGB(128, 126, 177)];
    [headLabel setFont:[UIFont systemFontOfSize:14]];
    return headLabel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==_tableView) {
        if (self.selectSchool != nil) {
            BmobObject *dict = [_nameArray objectAtIndex:indexPath.row];
            NSString *titleName = [dict objectForKey:@"name"];
            self.selectSchool (titleName);   //block传值
            self.selectSchool = nil;
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    else{
        if (self.selectSchool != nil) {
            BmobObject *dict = [_searchArray objectAtIndex:indexPath.row];
            NSString *titleName = [dict objectForKey:@"name"];
            self.selectSchool (titleName);   //block传值
            self.selectSchool = nil;
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view || touch.view == _mainView || touch.view == _tableView) {
        [self resignFirstResponder];
    }
}
- (BOOL)resignFirstResponder {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES]; //关闭键盘
    return [super resignFirstResponder];
}


@end
