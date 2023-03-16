//
//  BlockChooseGoodsVC.h
//  OCDemol
//
//  Created by 冯汉栩 on 2019/10/15.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockChooseGoodsVC : UIViewController

+ (void)showVC:(UIViewController *)vc byCallBlock:(void (^)(NSString *))callBlock;

@end

NS_ASSUME_NONNULL_END


