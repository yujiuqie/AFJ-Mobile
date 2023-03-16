//
//  ZLMultilineTextCell.m
//  ZLCollectionView
//
//  Created by zhaoliang chen on 2018/7/26.
//  Copyright © 2018年 zhaoliang chen. All rights reserved.
//

#import "ZLMultilineTextCell.h"

@implementation ZLMultilineTextCell

+ (NSString *)cellIdentifier {
    return @"ZLMultilineTextCell";
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
    ZLMultilineTextCell *cell = (ZLMultilineTextCell*)[collectionView dequeueReusableCellWithReuseIdentifier:[ZLMultilineTextCell cellIdentifier] forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = UIColorFromRGB(0xc4e9ff);
        self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
        self.contentView.layer.borderWidth = 0.4;
        
        self.label = [UILabel new];
        self.label.numberOfLines = 0;
        self.label.font = [UIFont systemFontOfSize:15];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return self;
}



//-(UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
//    [self setNeedsLayout];
//    [self layoutIfNeeded];
//    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
//    CGRect cellFrame = layoutAttributes.frame;
//    cellFrame.size.height= size.height;
//    layoutAttributes.frame= cellFrame;
//    return layoutAttributes;
//}

@end
