//
//  BMKRoutePlanSearchView.m
//  BMKTransitRoutePlanDemo
//
//  Created by baidu on 2020/5/25.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKRoutePlanSearchView.h"

@interface BMKRoutePlanSearchView () <UITextFieldDelegate>
@end

@implementation BMKRoutePlanSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadSubView];
    }
    return self;
}

- (void)loadSubView {
    [self setBackgroundColor:[COLOR(0x22253D) colorWithAlphaComponent:0.8]];
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(15 * widthScale, 14 * widthScale, SCREENW - 30 * widthScale, 76 * widthScale)];
    [searchView setBackgroundColor:COLOR(0x292B3C)];
    searchView.layer.cornerRadius = 4 * widthScale;
    searchView.layer.masksToBounds = YES;
    [self addSubview:searchView];

    UIImageView *startImageView = [[UIImageView alloc] initWithFrame:CGRectMake(19 * widthScale, 14 * widthScale, 9 * widthScale, 9 * widthScale)];
    [startImageView setImage:[UIImage imageNamed:@"路线检索-起点"]];
    [searchView addSubview:startImageView];

    UIImageView *pointsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21.5 * widthScale, 30 * widthScale, 4 * widthScale, 17.5 * widthScale)];
    [pointsImageView setImage:[UIImage imageNamed:@"Line 3"]];
    [searchView addSubview:pointsImageView];

    UIImageView *endImageView = [[UIImageView alloc] initWithFrame:CGRectMake(19 * widthScale, 53 * widthScale, 9 * widthScale, 9 * widthScale)];
    [endImageView setImage:[UIImage imageNamed:@"路线检索-终点"]];
    [searchView addSubview:endImageView];

    _startTextField = [[UITextField alloc] initWithFrame:CGRectMake(40 * widthScale, 7.5 * widthScale, SCREENW - 160 * widthScale, 21 * widthScale)];
    _startTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14 * widthScale];
    NSAttributedString *placeholderStart = [[NSAttributedString alloc] initWithString:@"请输入起点" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName: _startTextField.font}];
    _startTextField.attributedPlaceholder = placeholderStart;
    _startTextField.textColor = [UIColor whiteColor];
    _startTextField.text = @"百度科技园";
    _startTextField.delegate = self;
    [searchView addSubview:_startTextField];

    _endTextField = [[UITextField alloc] initWithFrame:CGRectMake(40 * widthScale, 47.5 * widthScale, SCREENW - 160 * widthScale, 21 * widthScale)];
    _endTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14 * widthScale];
    NSAttributedString *placeholderEnd = [[NSAttributedString alloc] initWithString:@"请输入终点" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName: _endTextField.font}];
    _endTextField.attributedPlaceholder = placeholderEnd;
    _endTextField.textColor = [UIColor whiteColor];
    _endTextField.text = @"西二旗地铁站";
    _endTextField.delegate = self;
    [searchView addSubview:_endTextField];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(40 * widthScale, 40 * widthScale, SCREENW - 145 * widthScale, 1)];
    [line setBackgroundColor:COLOR(0x4B4F6C)];
    [searchView addSubview:line];

    _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENW - 97 * widthScale, 24.5 * widthScale, 60 * widthScale, 30 * widthScale)];
    [_searchButton setBackgroundColor:COLOR(0x4B4F6C)];
    [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchButton.titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:13 * widthScale]];
    [_searchButton addTarget:self action:@selector(walkRoutePlanSearch) forControlEvents:UIControlEventTouchUpInside];
    _searchButton.layer.cornerRadius = 15 * widthScale;
    _searchButton.layer.masksToBounds = YES;
    [searchView addSubview:_searchButton];

}

- (void)walkRoutePlanSearch {
    [_startTextField resignFirstResponder];
    [_endTextField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didClickSearchButton)]) {
        [self.delegate performSelector:@selector(didClickSearchButton)];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_startTextField resignFirstResponder];
    [_endTextField resignFirstResponder];
    return YES;
}

@end
