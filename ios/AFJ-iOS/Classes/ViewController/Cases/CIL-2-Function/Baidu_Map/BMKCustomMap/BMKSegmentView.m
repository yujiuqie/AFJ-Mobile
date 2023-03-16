//
//  BMKSegmentView.m
//  BMKCustomMapDemo
//
//  Created by baidu on 2020/7/24.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "BMKSegmentView.h"

@interface BMKSegmentView ()

@property(nonatomic, strong) UIButton *selectedBtn;

@end

@implementation BMKSegmentView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:70.f / 255.f green:73.f / 255.f blue:97.f / 255.f alpha:1.0f];
        [self setupViews];
    }

    return self;
}

- (void)segmentBtnAction:(UIButton *)btn {
    btn.backgroundColor = [COLOR(0x3D3F51) colorWithAlphaComponent:0.9];
    _selectedBtn.backgroundColor = [COLOR(0x22253D) colorWithAlphaComponent:0.9];
    _selectedBtn = btn;

    if (self.didClickSegmentBlock) {
        self.didClickSegmentBlock(btn.tag);
    }
}

- (void)setupViews {
    NSArray *titles = @[@"昼", @"夜", @"关闭个性化"];
    NSMutableArray *btns = [NSMutableArray array];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [COLOR(0x22253D) colorWithAlphaComponent:0.9];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 15;
        btn.layer.masksToBounds = YES;
        btn.tag = i;

        if (i == 1) {
            btn.backgroundColor = [COLOR(0x3D3F51) colorWithAlphaComponent:0.9];
            _selectedBtn = btn;
        }

        [btn addTarget:self action:@selector(segmentBtnAction:) forControlEvents:UIControlEventTouchUpInside];

        [btns addObject:btn];
    }

    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:btns];
    stackView.frame = CGRectMake(15, 5, self.frame.size.width - 30, self.frame.size.height - 10);
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.spacing = 10;

    [self addSubview:stackView];
}

@end
