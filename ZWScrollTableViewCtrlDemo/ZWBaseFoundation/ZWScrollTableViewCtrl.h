//
//  ZWScrollTableViewCtrlViewController.h
//  ZWScrollTableViewCtrl
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+EmpyFalseDataView.h"
#import <MJRefresh/MJRefresh.h>

@interface ZWScrollTableViewCtrl : UIViewController <UITableViewDataSource, UITableViewDelegate>

/** 底部scrollview **/
@property (nonatomic, weak) UIScrollView *scrollView;
/** 顶部导航按钮view **/
@property (nonatomic, weak) UIView *headerView;

/** 存放tableView集合 **/
@property (nonatomic, strong, readonly) NSArray *tableViews;
/** 存放导航按钮集合 **/
@property (nonatomic, strong, readonly) NSArray *headerNavBtns;
/** tableView显示个数 **/
@property (nonatomic, assign, readonly) NSInteger tableViewCount;

/** 根据count初始化所需tableView和导航按钮 **/
- (void)setUpTableViewAtCount:(NSInteger)count;
/** 导航按钮触发函数 **/
- (void)headerBtn:(UIButton *)sender didSelectAtIndex:(NSInteger)index;
/** 网络访问失败触发函数 **/
- (void)tableView:(UITableView *)tableView networkReloadDataAction:(UIButton *)sender;

/** 设置tableView下拉刷新控件 **/
- (void)setupPullDownRefreshWith:(UITableView *)tableView;
/** 设置tableView上拉刷新控件 **/
- (void)setupPullUpRefreshWith:(UITableView *)tableView;
/** tableView下拉触发函数 **/
- (void)tableViewPullDownRefresh:(UITableView *)tableView;
/** tableView上拉触发函数 **/
- (void)tableViewPullUpRefresh:(UITableView *)tableView;

@end
