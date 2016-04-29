//
//  UIView+UIView_EmpyFalseDataView.m
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIView+EmpyFalseDataView.h"
#import <objc/runtime.h>
#import "ZWConstant.h"
#import "UIView+FixRatio.h"

@implementation UIView (EmpyFalseDataView)

static char emptyDataViewKey;
static char networkReloadViewKey;
static char networkReloadBtnKey;

- (void)setupEmptyDataView {
    UIView *emptyDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    emptyDataView.userInteractionEnabled = NO;
    emptyDataView.hidden = YES;
    
    UIImage *icon = [UIImage imageNamed:kResourceSrcName(@"msg_ic_data")];
    UIImageView *verifyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width/2 - icon.size.width/2, kScreenSize.height / 2 - [UIView fixRatioHeightByIphone6:icon.size.height] * 2, icon.size.width, icon.size.height)];
    verifyImageView.image = icon;
    [emptyDataView addSubview:verifyImageView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(verifyImageView.frame), kScreenSize.width, 20)];
    tipLabel.text = kEmptyDataTip;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = kColorRGB(153, 153, 153, 1);
    tipLabel.font = [UIFont systemFontOfSize:15];
    [emptyDataView addSubview:tipLabel];
    
    [self addSubview:emptyDataView];
    [self setEmptyDataViewKey:emptyDataView];
}

- (void)setupNetworkReloadView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, CGRectGetHeight(self.frame))];
    view.backgroundColor = [UIColor whiteColor];
    view.hidden = YES;
    
    UIImage *icon = [UIImage imageNamed:kResourceSrcName(@"msg_network")];
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
    [reloadButton setImage:[UIImage imageNamed:kResourceSrcName(@"msg_ic_loading")] forState:UIControlStateNormal];
    [reloadButton setImage:[UIImage imageNamed:kResourceSrcName(@"msg_ic_loading_sel")] forState:UIControlStateSelected];
    [view addSubview:reloadButton];
    
    [self addSubview:view];
    [self setNetworkReloadViewKey:view];
    [self setNetworkReloadBtnKey:reloadButton];
}

- (void)setEmptyDataViewKey:(UIView *)view {
    objc_setAssociatedObject(self, &emptyDataViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNetworkReloadViewKey:(UIView *)view {
    objc_setAssociatedObject(self, &networkReloadViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNetworkReloadBtnKey:(UIButton *)view {
    objc_setAssociatedObject(self, &networkReloadBtnKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)getEmptyDataViewKey {
    return objc_getAssociatedObject(self, &emptyDataViewKey);
}

- (UIView *)getNetworkReloadViewKey {
    return objc_getAssociatedObject(self, &networkReloadViewKey);
}

- (UIButton *)getNetworkReloadBtnKey {
    return objc_getAssociatedObject(self, &networkReloadBtnKey);
}

@end
