//
//  ZWScrollTableViewCtrlViewController.m
//  ZWScrollTableViewCtrl
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZWScrollTableViewCtrl.h"
#import "UIView+FixRatio.h"
#import "ZWConstant.h"

@interface ZWScrollTableViewCtrl () {
    __weak UILabel *_selectedLine;
}

@end

@implementation ZWScrollTableViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initGUI];
}

- (void)initGUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, 44)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headerView = headerView];
    
    UILabel *headerViewBottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(headerView.frame) - 0.5, CGRectGetWidth(headerView.frame), 0.5)];
    headerViewBottomLine.backgroundColor = kColorRGB(232, 232, 232, 1);
    [headerView addSubview:headerViewBottomLine];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), kScreenSize.width, kScreenSize.height - CGRectGetHeight(headerView.frame) - 44)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:_scrollView = scrollView];
}

#pragma mark 空数据view
- (UIView *)createEmptyDataView {
    UIView *emptyDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, CGRectGetHeight(_scrollView.frame))];
    emptyDataView.userInteractionEnabled = NO;
    emptyDataView.hidden = YES;
    
    UIImage *icon = [UIImage imageNamed:kRefreshSrcName(@"msg_ic_data")];
    UIImageView *verifyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width/2 - icon.size.width/2, kScreenSize.height / 2 - [UIView fixRatioHeightByIphone6:icon.size.height] * 2, icon.size.width, icon.size.height)];
    verifyImageView.image = icon;
    [emptyDataView addSubview:verifyImageView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(verifyImageView.frame), kScreenSize.width, 20)];
    tipLabel.text = kEmptyDataTip;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = kColorRGB(153, 153, 153, 1);
    tipLabel.font = [UIFont systemFontOfSize:15];
    [emptyDataView addSubview:tipLabel];
    
    return emptyDataView;
}

#pragma mark 网络请求错误view
- (UIView *)createNetworkReloadView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, CGRectGetHeight(_scrollView.frame))];
    view.backgroundColor = [UIColor whiteColor];
    view.hidden = YES;
    
    UIImage *icon = [UIImage imageNamed:kRefreshSrcName(@"msg_network")];
    UIImageView *verifyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width/2 - icon.size.width/2, kScreenSize.height / 2 - [UIView fixRatioHeightByIphone6:icon.size.height * 2], icon.size.width, icon.size.height)];
    verifyImageView.image = icon;
    verifyImageView.userInteractionEnabled = NO;
    [view addSubview:verifyImageView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(verifyImageView.frame) + 25, kScreenSize.width, 20)];
    tipLabel.text = kNetworkConnectFailTip;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = kColorRGB(153, 153, 153, 1);
    tipLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:tipLabel];
    
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadButton.frame = CGRectMake((kScreenSize.width - 112) / 2, CGRectGetMaxY(tipLabel.frame) + 13, 112, 32);
    [reloadButton setImage:[UIImage imageNamed:kRefreshSrcName(@"msg_ic_loading")] forState:UIControlStateNormal];
    [reloadButton setImage:[UIImage imageNamed:kRefreshSrcName(@"msg_ic_loading_sel")] forState:UIControlStateSelected];
    [reloadButton addTarget:self action:@selector(tableNetworkReloadDataAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:reloadButton];
    
    return view;
}

#pragma mark 按传入的count个数初始化tableView以及导航按钮
- (void)setUpTableViewAtCount:(NSInteger)count {
    _tableViewCount = count;
    
    NSMutableArray *btns = [NSMutableArray array];
    NSMutableArray *tableViews = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        // init button
        UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headerBtn.frame = CGRectMake(CGRectGetWidth(_headerView.frame) / count * i, 0, CGRectGetWidth(_headerView.frame) / count, CGRectGetHeight(_headerView.frame) - 1.0);
        headerBtn.backgroundColor = [UIColor whiteColor];
        [headerBtn setTitleColor:kColorRGB(51, 51, 51, 1) forState:UIControlStateNormal];
        [headerBtn setTitleColor:kColorRGB(54, 201, 251, 1) forState:UIControlStateSelected];
        headerBtn.titleLabel.font = [UIFont systemFontOfSize: kIsIphone4s ? 14 : 16];
        [headerBtn setTitle:[NSString stringWithFormat:@"btn%d", i] forState:UIControlStateNormal];
        headerBtn.selected = i == 0;
        [headerBtn addTarget:self action:@selector(headerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:headerBtn];
        [btns addObject:headerBtn]; // 存入临时按钮集合
        
        // 导航按钮之间的分割线
        UILabel *separatorLine = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_headerView.frame) / count * i, 10, 0.5, CGRectGetHeight(_headerView.frame) - 20)];
        separatorLine.backgroundColor = kColorRGB(232, 232, 232, 1);
        [_headerView addSubview:separatorLine];
        
        // init tableView
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenSize.width * i, 0, kScreenSize.width, CGRectGetHeight(_scrollView.frame))];
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        [_scrollView addSubview:tableView];
        [tableViews addObject:tableView]; // 存入临时tableView集合
        
        // 创建空数据view，并赋到tableView分类的关联中
        UIView *emptyDataView = [self createEmptyDataView];
        [tableView addSubview:emptyDataView];
        [tableView setEmptyDataViewKey:emptyDataView];
        
        // 创建网络访问错误view，并赋到tableView分类的关联中
        UIView *networkReloadView = [self createNetworkReloadView];
        [tableView addSubview:networkReloadView];
        [tableView setNetworkReloadViewKey:networkReloadView];
    }
    _headerNavBtns = btns; // 赋值给按钮集合对象，供外部访问
    _tableViews = tableViews; // 赋值给tableView集合对象，供外部访问
    
    // 按钮底部选中线
    UILabel *selectedLine = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_headerView.frame) - 2.0, CGRectGetWidth(_headerView.frame) / count, 2.0)];
    selectedLine.backgroundColor = kColorRGB(54, 201, 251, 1);
    [_headerView addSubview:_selectedLine = selectedLine];
    
    _scrollView.contentSize = CGSizeMake(kScreenSize.width*count, CGRectGetHeight(_scrollView.frame));
}

#pragma mark 根据tableView设置下拉刷新
- (void)setupPullDownRefreshWith:(UITableView *)tableView {
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewPullDownRefresh)];
    tableView.mj_header = refreshHeader;
}

#pragma mark 根据tableView设置上拉刷新
- (void)setupPullUpRefreshWith:(UITableView *)tableView {
    MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewPullUpRefresh)];
    refreshFooter.automaticallyHidden = YES;
    tableView.mj_footer = refreshFooter;
}

#pragma mark 下拉刷新触发函数
- (void)tableViewPullDownRefresh {
    NSInteger index = _scrollView.contentOffset.x / kScreenSize.width;
    [self tableViewPullDownRefresh:[_tableViews objectAtIndex:index]];
}

#pragma mark 上拉刷新触发函数
- (void)tableViewPullUpRefresh {
    NSInteger index = _scrollView.contentOffset.x / kScreenSize.width;
    [self tableViewPullUpRefresh:[_tableViews objectAtIndex:index]];
}

#pragma mark 下拉刷新对外访问函数，提供tableView
- (void)tableViewPullDownRefresh:(UITableView *)tableView {
    NSLog(@"tableViewPullDownRefresh");
}

#pragma mark 上拉刷新对外访问函数，提供tableView
- (void)tableViewPullUpRefresh:(UITableView *)tableView {
    NSLog(@"tableViewPullUpRefresh");
}

#pragma mark tableVew delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

#pragma mark 导航按钮触发函数
- (void)headerBtnAction:(UIButton *)sender {
    if (sender.selected) return;
    
    sender.selected = YES;
    NSInteger index = [_headerNavBtns indexOfObject:sender];
    [_scrollView setContentOffset:CGPointMake(kScreenSize.width * index, 0) animated:YES];
    [self setUpHeaderBtnSelectedAtIndex:index]; // 根据selected调整所有导航按钮样式
    
    [self headerBtn:sender didSelectAtIndex:index]; // 调用对外按钮访问函数
}

#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.scrollView) return;
    
    CGRect rect = _selectedLine.frame;
    rect.origin.x = scrollView.contentOffset.x / _tableViewCount;
    _selectedLine.frame = rect;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView != self.scrollView) return;
    
    NSInteger page = scrollView.contentOffset.x / kScreenSize.width;
    [self setUpHeaderBtnSelectedAtIndex:page];
}

#pragma mark 根据传入索引调整所有导航按钮样式
- (void)setUpHeaderBtnSelectedAtIndex:(NSInteger)index {
    for (int i = 0; i < _headerNavBtns.count; i++) {
        UIButton *btn = _headerNavBtns[i];
        btn.selected = i == index;
    }
}

#pragma mark tableVew网络访问错误触发函数
- (void)tableNetworkReloadDataAction:(UIButton *)sender {
    NSInteger index = _scrollView.contentOffset.x / kScreenSize.width;
    [self tableView:_tableViews[index] networkReloadDataAction:sender];
}

- (void)tableView:(UITableView *)tableView networkReloadDataAction:(UIButton *)sender {
    NSLog(@"ZWScrollTableViewCtrlViewController tableNetworkReloadDataAction");
}

#pragma mark 导航按钮统一对外访问函数
- (void)headerBtn:(UIButton *)sender didSelectAtIndex:(NSInteger)index {
    NSLog(@"ZWScrollTableViewCtrlViewController didSelectAtIndex");
}

@end
