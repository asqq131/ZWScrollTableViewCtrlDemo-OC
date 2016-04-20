//
//  FrostedRootViewController.h
//  sub-EXG
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 侧滑菜单枚举值
 */
typedef NS_ENUM(NSInteger, MenuPanType) {
    MenuPanTypeHome,
    MenuPanTypeLeft,
    MenuPanTypeRight
};

@class ZWBaseTabBarCtrl;
@class ZWMenuTableViewCtrl;
@interface ZWFrostedRootViewCtrl : UIViewController

@property (nonatomic, strong) ZWBaseTabBarCtrl *tabBarController;

@property (nonatomic, strong) ZWMenuTableViewCtrl *leftTableViewController;

/*
 * 主页 = 侧滑菜单 + UITabBarController
 */
@property (nonatomic, weak) UIView *mainView;

/*
 * 背景图
 */
@property (weak, nonatomic) UIImageView *bgImageView;

/*
 * 侧滑动画覆盖框
 */
@property (weak, nonatomic) UIView *blackCover;

/*
 * 侧滑菜单枚举值
 */
@property (nonatomic, assign) MenuPanType menuPanType;

/*
 * 显示左侧侧滑菜单
 */
- (void)showLeft;

/*
 * 显示UITabBarController当前页
 */
- (void)showHome;

/*
 * 添加手指侧滑手势
 */
- (void)addPanGestureToMainView;

/*
 * 删除手指侧滑手势
 */
- (void)removePanGestureFromMainView;

@end
