//
//  FhxMarginLabel.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2020/3/10.
//  Copyright © 2020 fenghanxu.compang.cn. All rights reserved.
//

@interface FhxMarginLabel ()

@property(assign, nonatomic) UIEdgeInsets edgeInsets;

@property(nonatomic, assign) CGFloat horizontal;

@property(nonatomic, assign) CGFloat portrait;

@end

@implementation FhxMarginLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.edgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withPortrait:(CGFloat)portrait withHorizontal:(CGFloat)horizonta {
    self = [super initWithFrame:frame];
    self.portrait = portrait;
    self.horizontal = horizonta;
    self.edgeInsets = UIEdgeInsetsMake(self.portrait, self.horizontal, self.portrait, self.horizontal);
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.edgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
}

// 修改绘制文字的区域，edgeInsets增加bounds
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    /*
     调用父类该方法
     注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
     */
    CGRect rect = [super     textRectForBounds:UIEdgeInsetsInsetRect(bounds,
            self.edgeInsets) limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.edgeInsets.left;
    rect.origin.y -= self.edgeInsets.top;
    rect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}

//绘制文字
- (void)drawTextInRect:(CGRect)rect {
    if (self.text && ![self.text isEqualToString:@""]) {
        //令绘制区域为原始区域，增加的内边距区域不绘制
        [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
        self.hidden = NO;
    } else {
        [super drawTextInRect:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsZero)];
        self.hidden = YES;
    }
}


@end
