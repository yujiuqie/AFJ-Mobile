//
//  FHXFloatWinView.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/4/16.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

#import "FHXFloatWinCell.h"
#import "NerdyUI.h"

@interface FHXFloatWinView () <UITableViewDataSource, UITableViewDelegate, FHXFloatWinCellDelegate>
@property(nonatomic, copy) FHXFloatWinViewBlcok block;
@property(nonatomic, assign) CGRect rect;
@property(nonatomic, strong) NSMutableArray<NSString *> *list;
@property(nonatomic, strong) UITableView *tableview;
@end

@implementation FHXFloatWinView

+ (void)showViewWithRect:(CGRect)rect withList:(NSMutableArray<NSString *> *)list withBlock:(FHXFloatWinViewBlcok)block {
    for (UIView *view in [GetVC getCurrentViewController].view.subviews) {
        if ([view isKindOfClass:[FHXFloatWinView class]]) {
            return;
        }
    }
    FHXFloatWinView *floatView = [[FHXFloatWinView alloc] initWithRect:rect withList:list withBlock:block];
    floatView.addTo([GetVC getCurrentViewController].view).xywh(rect.origin.x, rect.origin.y, rect.size.width, list.count < 5 ? list.count * 40 : 5 * 40);
    floatView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        floatView.alpha = 1;
    }                completion:^(BOOL finished) {
//    [UIView animateWithDuration:0.3 animations:^{ floatView.bgView.alpha = 1; }];
    }];
}

- (instancetype)initWithRect:(CGRect)rect withList:(NSMutableArray<NSString *> *)list withBlock:(FHXFloatWinViewBlcok)block {
    self = [super init];
    if (self) {
        self.rect = rect;
        self.list = list;
        self.block = block;
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.borderRadius(5);
    self.backgroundColor = [UIColor whiteColor];

    self.tableview = [UITableView new];
    self.tableview.addTo(self);
    self.tableview.bounces = NO;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor whiteColor];
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.showsHorizontalScrollIndicator = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.tableview.rowHeight = 40;
    [self.tableview registerClass:[FHXFloatWinCell class] forCellReuseIdentifier:@"kFHXFloatWinCellID"];
    //为解决tableview  Group的问题
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.tableview.sectionHeaderHeight = CGFLOAT_MIN;
    self.tableview.sectionFooterHeight = CGFLOAT_MIN;
    //为解决ios11 后tableview刷新跳动的问题
    self.tableview.estimatedRowHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    self.tableview.makeCons(^{
        make.left.right.equal.view(self);
        make.top.equal.view(self);
        make.bottom.equal.view(self);
    });

}

#pragma  mark UITableViewDelegate 的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FHXFloatWinCell *cell = [FHXFloatWinCell cellWithTableView:tableView];
    cell.model = self.list[indexPath.item];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.block(self.list[indexPath.item], @"点击");
    [self cancelFloatView];
}

- (void)fhxFloatWinCell:(FHXFloatWinCell *)cell returnPhoneNum:(NSString *)num {
    self.block(num, @"删除");
    [self.list removeObject:num];
    [self.tableview reloadData];
    self.xywh(self.rect.origin.x, self.rect.origin.y, self.rect.size.width, self.list.count < 5 ? self.list.count * 40 : 5 * 40);
    [self layoutIfNeeded];
}

+ (void)cancelFloatView {
    for (UIView *view in [GetVC getCurrentViewController].view.subviews) {
        if ([view isKindOfClass:[FHXFloatWinView class]]) {
            [(FHXFloatWinView *) view cancelFloatView];
        }
    }
}

- (void)cancelFloatView {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }                completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end


