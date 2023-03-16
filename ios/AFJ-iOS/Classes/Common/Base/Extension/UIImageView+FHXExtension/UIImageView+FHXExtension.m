//
//  UIImageView+FHXExtension.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/11/8.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

@implementation UIImageView (FHXExtension)

- (void)setHeader:(NSString *)url {
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.image = image ? [image circleImage] : nil;
    }];
}

@end
