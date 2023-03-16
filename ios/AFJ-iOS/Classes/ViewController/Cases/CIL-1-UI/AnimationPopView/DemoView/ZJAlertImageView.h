//
//  ZJAlertImageView.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/3.
//

#import "ZJXibFoctory.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJAlertImageView : ZJXibFoctory

@property(weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic, copy) void (^canceSureActionBlock)(BOOL isSure);

- (void)setupImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
