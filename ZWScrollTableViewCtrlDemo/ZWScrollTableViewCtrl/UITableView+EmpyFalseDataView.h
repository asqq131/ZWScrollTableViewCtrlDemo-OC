//
//  UITableView+EmpyFalseDataView.h
//  ZWScrollTableViewCtrl
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmpyFalseDataView)

/** 设置tableView空数据view关联 **/
- (void)setEmptyDataViewKey:(UIView *)view;
/** 设置tableView网络请求失败view关联 **/
- (void)setNetworkReloadViewKey:(UIView *)view;

/** 获取tableView空数据view关联 **/
- (UIView *)getEmptyDataViewKey;
/** 获取tableView网络请求失败view关联 **/
- (UIView *)getNetworkReloadViewKey;

@end
