//
//  BaseTableView.h
//  Sinaweibo
//
//  Created by 3024 on 14-1-7.
//  Copyright (c) 2014年 WuChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
//定义一个delegate
@class BaseTableView;
@protocol UITableViewEventDelegate <NSObject>
@optional
- (void)pullDown:(BaseTableView *)tableview;  //下拉
- (void)pullUp:(BaseTableView *)tableview;    //上拉
- (void)tableView:(BaseTableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;      //选中一个cell

@end

@interface BaseTableView : UITableView<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    EGORefreshTableHeaderView *_refreshTableview;
    BOOL _reloading;
    UIButton *moreBtn;  //加载更多按钮
    UIActivityIndicatorView *activity;  //风火轮
    int language;

}
@property(nonatomic,assign)BOOL refreshHeard;  //是否需要下拉
@property(nonatomic,strong)NSArray *data; //为tableview提供数据
@property(nonatomic,assign)id<UITableViewEventDelegate>eventdelegate;
@property(nonatomic,assign)BOOL isMore;
-(void)doneLoadingTableViewData;
- (void)refreshData;
@end
