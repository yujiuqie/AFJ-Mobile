//
// UIButton+TcExtension.m
//

static void *clickKey = &clickKey;

@implementation UIButton (TcExtension)

- (void)setImagePosition:(Tc_ImagePosition)postion spacing:(CGFloat)spacing {
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];

    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-    Wdeprecated-declarations"

    /**
     *size with Font: is deprecated ,now use the size withAttributes:
     */
    // CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    // CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;

    CGFloat labelWidth = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}].height;


#pragma clang diagnostic pop

    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离

    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;

    switch (postion) {
        case Tc_ImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing / 2, 0, spacing / 2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, -spacing / 2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, spacing / 2);
            break;

        case Tc_ImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing / 2, 0, -(labelWidth + spacing / 2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing / 2), 0, imageWidth + spacing / 2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing / 2, 0, spacing / 2);
            break;

        case Tc_ImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth / 2, changedHeight - imageOffsetY, -changedWidth / 2);
            break;

        case Tc_ImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight - imageOffsetY, -changedWidth / 2, imageOffsetY, -changedWidth / 2);
            break;

        default:
            break;
    }

}

- (void)setNormalTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setSelectedTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateSelected];
}

- (void)setNormalImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
}

- (void)setSelectedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateSelected];
}

- (void)setBgColor:(UIColor *)color {
    self.backgroundColor = color;
}

- (void)setTextColor:(UIColor *)textColor {
    [self setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)setFont:(UIFont *)font {
    self.titleLabel.font = font;
}

- (void)setBgImg:(UIImage *)bgImg {
    [self setBackgroundImage:bgImg forState:UIControlStateNormal];
}

- (void)setTextPolsition:(NSTextAlignment)alignment {
    self.titleLabel.textAlignment = alignment;
}

- (instancetype)setText:(NSString *)text
              TextColor:(UIColor *)textColor
                   Font:(UIFont *)font {
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitleColor:textColor forState:UIControlStateNormal];
    self.titleLabel.font = font;
    return self;
}

- (void)setClickBlock:(void (^)(UIButton *button))clickBlock {
    objc_setAssociatedObject(self, &clickKey, clickBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIButton *button))clickBlock {
    return objc_getAssociatedObject(self, &clickKey);
}

- (void)setOnclick:(void (^)(UIButton *button))block {
    self.clickBlock = block;
    [self addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickBtn:(UIButton *)sender {
    self.clickBlock(sender);
}
@end
