//
//  ViewController.m
//  ZWScrollTableViewCtrlDemo
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableViewAtCount:4];

//    [self.tableViews[0] getNetworkReloadViewKey].hidden = NO;
//    [self.tableViews[2] getEmptyDataViewKey].hidden = NO;
    [self setupPullDownRefreshWith:self.tableViews[0]];
    [self setupPullUpRefreshWith:self.tableViews[1]];
    [[self.tableViews[0] mj_header] beginRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    switch ([self.tableViews indexOfObject:tableView]) {
        case 0:
            cell.textLabel.text = @"leftTableView";
            break;
        case 1:
            cell.textLabel.text = @"middleTableView";
            break;
        case 2:
            cell.textLabel.text = @"rightTableView";
            break;
            
        default:
            cell.textLabel.text = @"test";
            break;
    }
    
    return cell;
}

- (void)headerBtn:(UIButton *)sender didSelectAtIndex:(NSInteger)index {
    NSLog(@"%ld", (long)index);
}

- (void)tableViewPullDownRefresh:(UITableView *)tableView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView.mj_header endRefreshing];
    });
}

- (void)tableViewPullUpRefresh:(UITableView *)tableView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView.mj_footer endRefreshing];
    });
}

- (void)tableView:(UITableView *)tableView networkReloadDataAction:(UIButton *)sender {
    [tableView.mj_header beginRefreshing];
}

@end
