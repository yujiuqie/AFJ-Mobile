//
//  BMKSecondaryCataloguePage.m
//  BMKObjectiveCDemo
//
//  Created by Baidu RD on 2018/3/6.
//  Copyright © 2018年 Baidu. All rights reserved.
//

#import "BMKSecondaryCataloguePage.h"

static NSString *cellIdentifier = @"com.Baidu.BMKCatalogueTableViewCell";

@interface BMKSecondaryCataloguePage () <UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) UITableView *tableView;
@end

@implementation BMKSecondaryCataloguePage

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self createTableView];
}

#pragma mark - Config UI

- (void)configUI {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _currentTitle;
    [self.view addSubview:self.tableView];
}

- (void)createTableView {
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[BMKCatalogueTableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _catalogueDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMKCatalogueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell refreshUIWithData:_catalogueDatas images:nil atIndexPath:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *tempArray = [[_catalogueDatas objectAtIndex:indexPath.row] allValues];
    NSString *classString = tempArray[0][1];
    UIViewController *page = (UIViewController *) [[NSClassFromString(classString) alloc] init];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = barButtonItem;
    [self.navigationController pushViewController:page animated:YES];
}

#pragma mark - Lazy loading

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH - kViewTopHeight - KiPhoneXSafeAreaDValue) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

@end
