//
//  BaseTableView.m
//  Sinaweibo
//
//  Created by 3024 on 14-1-7.
//  Copyright (c) 2014年 WuChao. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:@"kReloadWeibo" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inittext) name:@"kReloadWeibolanguage" object:nil];
        [self inittext];
        [self initView];
    }
    return self;
}

- (void)initView{
    _refreshTableview = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0, 0-self.bounds.size.height+10,self.frame.size.width,self.bounds.size.height)];
    _refreshTableview.delegate=self;
    //将下拉刷新控件添加到UITableView中
    [self addSubview:_refreshTableview];
    self.dataSource=self;
    self.delegate=self;
    self.refreshHeard = YES;
    
    moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(0, 0, 320, 40);
    [moreBtn setBackgroundColor:[UIColor clearColor]];
    [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.frame = CGRectMake(95, 10, 20, 20);
    [activity stopAnimating];
    [moreBtn addSubview:activity];
    
    self.tableFooterView = moreBtn;
    
    
}
-(void)inittext{
    [moreBtn setTitle:@"加载更多..." forState:UIControlStateNormal];
}
- (void)moreBtnAction{
    NSLog(@"上拉刷新");
    if ([self.eventdelegate respondsToSelector:@selector(pullUp:)]) {
        [self.eventdelegate pullUp:self];
        [self startreload];
    }
}
- (void)startreload{
    [moreBtn setTitle:@"正在加载..." forState:UIControlStateNormal];
    moreBtn.userInteractionEnabled = NO;
    [activity startAnimating];
    
}

-(void)reloadData{
    [super reloadData];
    if (self.data.count>0) {
        [moreBtn setTitle:@"加载更多..." forState:UIControlStateNormal];
        moreBtn.hidden = NO;
        moreBtn.userInteractionEnabled = YES;
        [activity stopAnimating];
    }
    else{
        moreBtn.hidden = YES;
    }
}
- (void)setRefreshHeard:(BOOL)refreshHeard{
    _refreshHeard = refreshHeard;
    if (_refreshHeard) {
        [self addSubview:_refreshTableview];
    }
    else{
        [_refreshTableview superclass];
        [_refreshTableview removeFromSuperview];
    }
}
-(void)refreshData{
    [_refreshTableview refresh:self];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.eventdelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.eventdelegate tableView:self didDeselectRowAtIndexPath:indexPath];
    }
}
//开始重新加载时调用的方法
-(void)reloadTableViewDataSource{
    NSLog(@"开始重新加载时调用的方法");
    _reloading = YES;
}

//完成加载时调用的方法
-(void)doneLoadingTableViewData{
    NSLog(@"完成加载时调用的方法");
    _reloading = NO;
    [_refreshTableview egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}
#pragma mark UIScrollViewDelegate Methods
//滚动控件的委托方法  当scrollView滑动时实时调用此方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshTableview egoRefreshScrollViewDidScroll:scrollView];
    
}
//手指停止拖拽时调用方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshTableview egoRefreshScrollViewDidEndDragging:scrollView];
    float offset = scrollView.contentOffset.y;   //偏移量
    float contentHeight = scrollView.contentSize.height; //高度
    NSLog(@"%f",offset);
    NSLog(@"%f",contentHeight);
    float sub = contentHeight - offset; //当偏移量滑到底部时 计算差值 及scrollView的高度
    if (sub - scrollView.height>30) {
        [self startreload];
        [self.eventdelegate pullUp:self];
    }
    
}
#pragma mark EGORefreshTableHeaderDelegate Methods

//下拉被触发调用的委托方法
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    //停止加载，弹回下拉
    //判断在此协议中是否有此方法
    if ([self.eventdelegate respondsToSelector:@selector(pullDown:)]) {
        [self.eventdelegate pullDown:self];
    }
	
}
//返回当前是刷新还是无刷新状态
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}
//返回刷新时间的回调方法
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

@end
