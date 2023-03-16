//
//  UILabel+FHXLabel.m
//  ShoppingMall
//
//  Created by 冯汉栩 on 2019/11/7.
//  Copyright © 2019 fenghanxu.compang.cn. All rights reserved.
//

@implementation UILabel (FHXLabel)

#pragma mark - 设置label行间距

- (void)fhxSetText:(NSString *)text lineSpacing:(CGFloat)lineSpacing {

    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];

    self.attributedText = attributedString;
}


- (NSString *)verticalText {
    // 利用runtime添加属性
    return objc_getAssociatedObject(self, @selector(verticalText));
}

- (void)setVerticalText:(NSString *)verticalText {
    objc_setAssociatedObject(self, &verticalText, verticalText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableString *str = [[NSMutableString alloc] initWithString:verticalText];
    NSInteger count = str.length;
    for (int i = 1; i < count; i++) {
        [str insertString:@"\n" atIndex:i * 2 - 1];
    }
    self.text = str;
    self.numberOfLines = 0;
}


@end
