//
//  MenuTableTableViewController.h
//  sub-EXG
//
//  Created by mac on 15/9/8.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ZWBaseTableViewCtrl.h"

@class ZWFrostedRootViewCtrl;
@interface ZWMenuTableViewCtrl : ZWBaseTableViewCtrl

/*
 * 侧滑主控制器
 */
@property (nonatomic, weak) ZWFrostedRootViewCtrl *frostedViewController;

@end
