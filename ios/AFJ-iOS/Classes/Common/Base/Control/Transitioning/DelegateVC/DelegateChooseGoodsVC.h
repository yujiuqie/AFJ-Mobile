//
//  DelegateChooseGoodsVC.h
//  OCDemol
//
//  Created by 冯汉栩 on 2019/10/15.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DelegateChooseGoodsVC;

@protocol DelegateChooseGoodsVCDelegate <NSObject>
- (void)delegateChooseGoodsVC:(DelegateChooseGoodsVC *)vc returnValue:(NSString *)value;
@end

@interface DelegateChooseGoodsVC : UIViewController

@property(nonatomic, weak) id <DelegateChooseGoodsVCDelegate> delegate;

+ (void)showVC:(UIViewController *)vc byDelegate:(id <DelegateChooseGoodsVCDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END


