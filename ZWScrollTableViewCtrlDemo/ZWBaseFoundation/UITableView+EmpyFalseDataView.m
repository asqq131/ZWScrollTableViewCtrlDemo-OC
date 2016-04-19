//
//  UITableView+EmpyFalseDataView.m
//  ZWScrollTableViewCtrl
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UITableView+EmpyFalseDataView.h"
#import <objc/runtime.h>

@implementation UITableView (EmpyFalseDataView)

static char emptyDataViewKey;
static char networkReloadViewKey;

- (void)setEmptyDataViewKey:(UIView *)view {
    objc_setAssociatedObject(self, &emptyDataViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)getEmptyDataViewKey {
    return objc_getAssociatedObject(self, &emptyDataViewKey);
}

- (void)setNetworkReloadViewKey:(UIView *)view {
    objc_setAssociatedObject(self, &networkReloadViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)getNetworkReloadViewKey {
    return objc_getAssociatedObject(self, &networkReloadViewKey);
}

@end
