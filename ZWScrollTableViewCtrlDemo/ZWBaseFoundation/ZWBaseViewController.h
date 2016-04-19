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

@property (nonatomic, strong) UIButton *navLeftBtn;
@property (nonatomic, strong) UIButton *navRightBtn;
@property (nonatomic, strong) UIView *reloadNetworkView;
@property (nonatomic, strong) UIView *emptyDataView;

- (void)showReloadNetworkViewAddedTo:(UIView *)view;
- (void)hideReloadNetworkView;
- (void)reloadNetworkDataAction:(UIButton *)sender;
- (void)showEmptyDataViewAddedTo:(UIView *)view;
- (void)hideEmptyDataView;
- (void)setEmptyTipText:(NSString *)text andImage:(UIImage *)image;
- (void)showTipWithString:(NSString *)tip;

@end
