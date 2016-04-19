//
//  ZWViewController.h
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWConstant.h"

@interface ZWBaseViewController : UIViewController

/** 导航栏左侧按钮 **/
@property (nonatomic, strong) UIButton *navLeftBtn;
/** 导航栏右侧按钮 **/
@property (nonatomic, strong) UIButton *navRightBtn;
/** 网络请求失败view **/
@property (nonatomic, strong) UIView *reloadNetworkView;
/** 空数据view **/
@property (nonatomic, strong) UIView *emptyDataView;

/** 创建网络请求失败view **/
- (void)showReloadNetworkViewAddedTo:(UIView *)view;
/** 删除网络请求失败view **/
- (void)hideReloadNetworkView;
/** 网络重新加载按钮事件 **/
- (void)reloadNetworkDataAction:(UIButton *)sender;

/** 创建空数据view **/
- (void)showEmptyDataViewAddedTo:(UIView *)view;
/** 删除空数据view **/
- (void)hideEmptyDataView;
/** 更改空数据提示语和图标 **/
- (void)setEmptyTipText:(NSString *)text andImage:(UIImage *)image;

/** 显示提示 **/
- (void)showTipWithString:(NSString *)tip;

@end
