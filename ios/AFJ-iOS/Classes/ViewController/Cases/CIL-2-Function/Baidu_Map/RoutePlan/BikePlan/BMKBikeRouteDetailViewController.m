//
//  BMKRouteDetailViewController.m
//  BMKWalkRoutePlanDemo
//
//  Created by baidu on 2020/5/21.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKBikeRouteDetailViewController.h"
#import "BMKBikeRouteLineTableViewCell.h"
#import "BMKBikeRouteDetailModel.h"

@interface BMKBikeRouteDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation BMKBikeRouteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"骑行路线规划详情页";
    self.view.backgroundColor = COLOR(0xf7f7f7);

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(10 * widthScale, 0, SCREENW - 20 * widthScale, 88 * widthScale)];

    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(17.5 * widthScale, 30 * widthScale, SCREENW - 45 * widthScale, 18 * widthScale)];
    topLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:19 * widthScale];
    topLabel.textColor = COLOR(0x333333);
    NSString *time;
    if (_routeLine.duration.minutes > 0) {
        time = [NSString stringWithFormat:@"%d分钟", _routeLine.duration.minutes];
    }
    if (_routeLine.duration.hours > 0) {
        time = [NSString stringWithFormat:@"%d小时", _routeLine.duration.hours];
    }
    if (_routeLine.duration.hours > 0 && _routeLine.duration.minutes > 0) {
        time = [NSString stringWithFormat:@"%d小时%d分", _routeLine.duration.hours, _routeLine.duration.minutes];
    }
    NSString *distance;
    if (_routeLine.distance < 100) {
        distance = [NSString stringWithFormat:@"%d米", _routeLine.distance];
    } else {
        distance = [NSString stringWithFormat:@"%.1f公里", _routeLine.distance / 1000.0];
    }
    NSString *duringString = [NSString stringWithFormat:@"%@ (%@)", time, distance];
    topLabel.text = duringString;
    [headView addSubview:topLabel];


    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, SCREENW - 20, SCREENH - (kViewTopHeight + KiPhoneXSafeAreaDValue))];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.tableHeaderView = headView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.sectionHeaderHeight = 10;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.routeLine.steps.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMKBikeRouteLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[BMKBikeRouteLineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        BMKBikeRouteDetailModel *model = [[BMKBikeRouteDetailModel alloc] init];
        model.instruction = @"起点";
        model.cellHeight = 64 * widthScale;
        NSDictionary *attrs = @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:16 * widthScale]};
        CGSize size = CGSizeMake(SCREENW - 86 * widthScale, MAXFLOAT);
        CGSize actualsize = [model.instruction boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        model.cellHeight = actualsize.height + 48 * widthScale;
        cell.detailModel = model;
        cell.leftImageView.image = [UIImage imageNamed:@"路线详情-起点"];
        cell.line.hidden = NO;
    } else if (indexPath.row == self.detailModels.count + 1) {
        BMKBikeRouteDetailModel *model = [[BMKBikeRouteDetailModel alloc] init];
        model.instruction = @"终点";
        model.cellHeight = 64 * widthScale;
        NSDictionary *attrs = @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:16 * widthScale]};
        CGSize size = CGSizeMake(SCREENW - 86 * widthScale, MAXFLOAT);
        CGSize actualsize = [model.instruction boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
        model.cellHeight = actualsize.height + 48 * widthScale;
        cell.detailModel = model;
        cell.leftImageView.image = [UIImage imageNamed:@"路线详情-终点"];
        cell.line.hidden = YES;
    } else {
        BMKBikeRouteDetailModel *model = ((BMKBikeRouteDetailModel *) self.detailModels[indexPath.row - 1]);
        cell.detailModel = model;
        cell.line.hidden = NO;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == self.detailModels.count + 1) {
        return 64 * widthScale;
    } else {
        BMKBikeRouteDetailModel *model = ((BMKBikeRouteDetailModel *) self.detailModels[indexPath.row - 1]);
        return model.cellHeight;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = COLOR(0xf7f7f7);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

@end
