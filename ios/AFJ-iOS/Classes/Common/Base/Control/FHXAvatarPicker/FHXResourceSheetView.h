//
//  FHXResourceSheetView.h
//  FHXAvatarPicker
//
//  Created by 冯汉栩 on 2019/4/6.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ResourceMode) {
    ResourceModeNone = 0,   // 取消选择
    ResourceModeCamera,
    ResourceModeAlbum
};

@class FHXResourceSheetView;

@protocol FHXResouceSheetViewDelegate <NSObject>

- (void)FHXResourceSheetView:(FHXResourceSheetView *)sheetView
                 seletedMode:(ResourceMode)resourceMode;
@end

@interface FHXResourceSheetView : UIView

// 持有强引用，调用接收后，手动置为空，不然 FHXAvatarPicker 会提前释放
@property(nonatomic, strong, nullable) id <FHXResouceSheetViewDelegate> delegate;

- (void)show;

@end

NS_ASSUME_NONNULL_END
