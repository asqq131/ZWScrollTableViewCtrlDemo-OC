//
//  ZWViewController.m
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZWBaseViewController.h"
#import "UIView+FixRatio.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ZWBaseViewController ()

//@property (nonatomic, strong) UIImageView *emptyDataVerifyImageView;
//@property (nonatomic, strong) UILabel *emptyDataTipLabel;

@end

@implementation ZWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 左侧导航按钮懒加载
- (UIButton *)navLeftBtn {
    if (!_navLeftBtn) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, 0, 50, 44);
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:kScreenSize.width < 375 ? 14 : 15];
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
        self.navigationItem.leftBarButtonItem = barBtn;
    }
    
    return _navLeftBtn;
}

#pragma mark 右侧导航按钮懒加载
- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 50, 44);
        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:kScreenSize.width < 375 ? 14 : 15];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItem = barBtn;
    }
    
    return _navRightBtn;
}

#pragma mark 网络请求失败view懒加载
- (UIView *)reloadNetworkView {
    if (!_reloadNetworkView) {
        UIView *reloadCoverView = [[UIView alloc] initWithFrame:self.view.bounds];
        reloadCoverView.backgroundColor = [UIColor clearColor];
        
        CGFloat viewHeight = 90;
        UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, viewHeight)];
        refreshView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        refreshView.layer.masksToBounds = YES;
        refreshView.layer.cornerRadius = 4.0;
        refreshView.center = reloadCoverView.center;
        [reloadCoverView addSubview:refreshView];
        
        CGSize reloadLabelSize = CGSizeMake(CGRectGetWidth(refreshView.frame), 35);
        UILabel *reloadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, reloadLabelSize.width, reloadLabelSize.height)];
        reloadLabel.font = [UIFont systemFontOfSize:13];
        reloadLabel.textColor = [UIColor whiteColor];
        reloadLabel.text = kNetworkConnectFailTip;
        reloadLabel.textAlignment = NSTextAlignmentCenter;
        [refreshView addSubview:reloadLabel];
        
        CGSize reloadBtnSize = CGSizeMake(70, 25);
        UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        reloadBtn.frame = CGRectMake((CGRectGetWidth(refreshView.frame) - reloadBtnSize.width) / 2, CGRectGetMaxY(reloadLabel.frame) + 5, reloadBtnSize.width, reloadBtnSize.height);
        reloadBtn.backgroundColor = kColorRGB(54, 201, 251, 1);
        [reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [reloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        reloadBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        reloadBtn.layer.masksToBounds = YES;
        reloadBtn.layer.cornerRadius = 5.0;
        [reloadBtn addTarget:self action:@selector(reloadNetworkDataAction:) forControlEvents:UIControlEventTouchUpInside];
        [refreshView addSubview:reloadBtn];
        
        _reloadNetworkView = reloadCoverView;
    }
    
    return _reloadNetworkView;
}

#pragma mark 空数据view懒加载
//- (UIView *)emptyDataView {
//    if (!_emptyDataView) {
//        UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
//        view.userInteractionEnabled = NO;
//        
//        [view addSubview:self.emptyDataVerifyImageView];
//        [view addSubview:self.emptyDataTipLabel];
//        
//        _emptyDataView = view;
//    }
//    
//    return _emptyDataView;
//}
//
//#pragma mark - Private 空数据提示图标懒加载
//- (UIImageView *)emptyDataVerifyImageView {
//    if (!_emptyDataVerifyImageView) {
//        UIImage *icon = [UIImage imageNamed:kResourceSrcName(@"msg_ic_data")];
//        UIImageView *verifyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width/2 - icon.size.width/2, kScreenSize.height / 2 - [UIView fixRatioHeightByIphone6:icon.size.height] / 2, icon.size.width, icon.size.height)];
//        verifyImageView.image = icon;
//        
//        _emptyDataVerifyImageView = verifyImageView;
//    }
//    
//    return _emptyDataVerifyImageView;
//}
//
//#pragma mark Private 空数据提示语标懒加载
//- (UILabel *)emptyDataTipLabel {
//    if (!_emptyDataTipLabel) {
//        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.emptyDataVerifyImageView.frame), kScreenSize.width, 20)];
//        tipLabel.text = kEmptyDataTip;
//        tipLabel.textAlignment = NSTextAlignmentCenter;
//        tipLabel.textColor = kColorRGB(153, 153, 153, 1);
//        tipLabel.font = [UIFont systemFontOfSize:15];
//        
//        _emptyDataTipLabel = tipLabel;
//    }
//    
//    return _emptyDataTipLabel;
//}

#pragma mark -

- (void)reloadNetworkDataAction:(UIButton *)sender {
    NSLog(@"ZWViewController reloadNetworkData");
}

- (void)showReloadNetworkViewAddedTo:(UIView *)view {
    [view addSubview:self.reloadNetworkView];
}

- (void)hideReloadNetworkView {
    [_reloadNetworkView removeFromSuperview];
    _reloadNetworkView = nil;
}

//- (void)showEmptyDataViewAddedTo:(UIView *)view {
//    [view addSubview:self.emptyDataView];
//}
//
//- (void)hideEmptyDataView {
//    [_emptyDataView removeFromSuperview];
//    _emptyDataView = nil;
//}
//
//- (void)setEmptyTipText:(NSString *)text andImage:(UIImage *)image {
//    if (_emptyDataTipLabel && text) {
//        _emptyDataTipLabel.text = text;
//    }
//    
//    if (_emptyDataVerifyImageView && image) {
//        _emptyDataVerifyImageView.image = image;
//    }
//}

- (void)showTipWithString:(NSString *)tip {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = tip;
    hud.labelFont = [UIFont systemFontOfSize:14];
    [hud hide:YES afterDelay:3.0];
}

@end
