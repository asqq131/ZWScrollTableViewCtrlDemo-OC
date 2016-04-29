//
//  UIView+UIView_EmpyFalseDataView.h
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EmpyFalseDataView)

/** 设置view空数据view关联 **/
- (void)setupEmptyDataView;
/** 设置view网络请求失败view关联 **/
- (void)setupNetworkReloadView;

/** 获取view空数据view关联 **/
- (UIView *)getEmptyDataViewKey;
/** 获取view网络请求失败view关联 **/
- (UIView *)getNetworkReloadViewKey;
/** 必须先初始化NetworkReloadView **/
- (UIButton *)getNetworkReloadBtnKey;

@end
