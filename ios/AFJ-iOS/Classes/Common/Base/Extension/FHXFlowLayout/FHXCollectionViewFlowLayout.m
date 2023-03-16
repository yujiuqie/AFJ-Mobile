//
//  GSCollectionViewFlowLayout.m
//  emall
//
//  Created by 冯汉栩 on 2019/4/25.
//  Copyright © 2019 HC360. All rights reserved.
//

@interface FHXCollectionViewFlowLayout ()

@end

@implementation FHXCollectionViewFlowLayout

#pragma mark - 初始化layout的结构和初始需要的参数

- (void)prepareLayout {
    [super prepareLayout];


}

//#pragma mark - cell的左右间距

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSMutableArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];

    /* 处理左右间距 */

    for (int i = 1; i < [answer count]; ++i) {

        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];

        UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];

        //注意：currentLayoutAttributes.indexPath.section 这里是单独处理某个section的空隙，如果不需要可把if判断删除即可
        if (currentLayoutAttributes.indexPath.section == 0) {

            NSInteger maximumSpacing = 0;

            NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);

            if (origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {

                CGRect frame = currentLayoutAttributes.frame;

                frame.origin.x = origin + maximumSpacing;

                currentLayoutAttributes.frame = frame;

            }
        }


    }

    return answer;

}

@end
