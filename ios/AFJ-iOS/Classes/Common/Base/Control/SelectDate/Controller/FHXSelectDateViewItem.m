//
//  LMTShareViewItem.m
//  Frame
//
//  Created by 冯汉栩 on 2016/11/20.
//  Copyright © 2016年 冯汉栩. All rights reserved.
//

#import "FHXMaskBtn.h"
//#import "Masonry.h"

@interface FHXSelectDateViewItem ()

@property(nonatomic, strong) UIWindow *mywindow;
@property(nonatomic, weak) FHXMaskBtn *zheZhaoBtn;
@property(nonatomic, weak) FHXSelectDateTankuangView *DateTankuangView;

@property(nonatomic, strong) void (^confirm)(NSString *dateStr);
@property(nonatomic, strong) void (^cancel)(void);

@property(nonatomic, assign) CGFloat viewH;

@property(nonatomic, assign) showDateType type;

@end

@implementation FHXSelectDateViewItem

static CGFloat durationT = 0.3;

+ (void)SelectDateViewItemWithShowDateType:(showDateType)showDateType Confirm:(void (^)(NSString *dateStr))confirm cancel:(void (^)(void))cancel {
//    NSLog(@"zenml");
    [[self alloc] initWithShowDateType:showDateType Confirm:confirm cancel:cancel];
}

- (instancetype)initWithShowDateType:(showDateType)showDateType Confirm:(void (^)(NSString *dateStr))confirm cancel:(void (^)(void))cancel {

    if (self = [super init]) {
        self.viewH = 230;
        self.confirm = confirm;
        self.cancel = cancel;
        self.type = showDateType;
        [self setUI];
    }
    return self;

}

- (void)setUI {
//    [[FHXSelectDateViewItem getCurrentWindow] addSubview:self.zheZhaoBtn];
    [self.mywindow addSubview:self.zheZhaoBtn];

    FHXSelectDateTankuangView *DateTankuangView = [FHXSelectDateTankuangView SelectDateTankuangViewWithShowDateType:self.type Confirm:^(NSString *dateStr) {
        self.confirm(dateStr);
        [self setDisapperAnimation];
    }                                                                                                        cancel:^{
        [self setDisapperAnimation];
        self.cancel();
    }];

//    FHXSelectDateTankuangView *DateTankuangView = [FHXSelectDateTankuangView SelectDateTankuangViewWithIsNeedTime:self.isNeedTime  Confirm:^(NSString *dateStr) {
//        self.confirm(dateStr);
//        [self setDisapperAnimation];
//    } cancel:^{
//        [self setDisapperAnimation];
//        self.cancel();
//    }];

    self.DateTankuangView = DateTankuangView;
    [self.mywindow addSubview:self.DateTankuangView];

    [self setConstraints];
}

- (void)setConstraints {
    self.zheZhaoBtn.frame = CGRectMake(0, 0, self.mywindow.bounds.size.width, self.mywindow.bounds.size.height);

    [self.DateTankuangView setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.DateTankuangView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.mywindow attribute:NSLayoutAttributeLeft multiplier:1 constant:0];

    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.DateTankuangView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.mywindow attribute:NSLayoutAttributeRight multiplier:1 constant:0];

    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.DateTankuangView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.mywindow attribute:NSLayoutAttributeBottom multiplier:1 constant:0];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.DateTankuangView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:self.viewH];

    [self.mywindow addConstraints:@[leftConstraint, bottomConstraint, rightConstraint, heightConstraint]];

//    [self.zheZhaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.mywindow);
//    }];
//    [self.DateTankuangView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.bottom.equalTo(self.mywindow);
//        make.height.mas_equalTo(self.viewH);
//    }];

    [self setShowAnimation];
}

/**
 *  动画结束代理
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self setCancel];
}

#pragma mark ---- 私有方法

/**
 *  显示collectionview
 */
- (void)setShowAnimation {
    // 核心动画的缺点：默认动画执行完毕会反弹
    // 创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    // keyPath:告诉图层执行什么动画(缩放，旋转，平移)，调整哪个属性来动画
    anim.keyPath = @"transform";

    // 设置平移的起点
    // 设置平移终点位置
    CATransform3D transform = CATransform3DMakeTranslation(0, self.viewH, 0);
    anim.fromValue = [NSValue valueWithCATransform3D:transform];
    CATransform3D transformTo = CATransform3DIdentity;
    anim.toValue = [NSValue valueWithCATransform3D:transformTo];
    // 设置动画执行时间
    anim.duration = durationT;
    // 保持动画指向完毕的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeBoth;
    // 将动画对象添加到图层上
    [self.DateTankuangView.layer addAnimation:anim forKey:nil];
}

/**
 *  隐藏collectionview
 */
- (void)setDisapperAnimation {
    // 核心动画的缺点：默认动画执行完毕会反弹
    // 创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    // keyPath:告诉图层执行什么动画(缩放，旋转，平移)，调整哪个属性来动画
    anim.keyPath = @"transform";
    anim.delegate = self;
    // 设置平移的起点
    // 设置平移终点位置
    CATransform3D transform = CATransform3DMakeTranslation(0, self.viewH, 0);
    anim.toValue = [NSValue valueWithCATransform3D:transform];
    // 设置动画执行时间
    anim.duration = durationT;
    // 保持动画指向完毕的状态
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeBoth;
    // 将动画对象添加到图层上
    [self.DateTankuangView.layer addAnimation:anim forKey:nil];
}

/**
 *  取消操作
 */
- (void)setCancel {
    [self.zheZhaoBtn removeFromSuperview];
    [self.DateTankuangView removeFromSuperview];

    self.zheZhaoBtn = nil;
    self.DateTankuangView = nil;
}

#pragma mark ----懒加载

- (UIWindow *)mywindow {
    if (_mywindow != nil) {
        return _mywindow;
    }

    //不能用这个，在swift里面这个是空的
    //UIWindow *view = [UIApplication sharedApplication].keyWindow;
    //用这个才能拿到
    UIWindow *view = [UIApplication sharedApplication].delegate.window;
    _mywindow = view;
    return _mywindow;
}

- (FHXMaskBtn *)zheZhaoBtn {
    if (_zheZhaoBtn != nil) {
        return _zheZhaoBtn;
    }
    FHXMaskBtn *view = [FHXMaskBtn zhenZhaoBtnWithComplete:^(FHXMaskBtn *zheZhaoBtn) {
//        LMTLog(@"分享遮罩按钮点击");
        [self setDisapperAnimation];
    }];
    _zheZhaoBtn = view;
    return _zheZhaoBtn;
}

+ (UIWindow *)getCurrentWindow {
    if ([[[UIApplication sharedApplication] delegate] window]) {
        return [[[UIApplication sharedApplication] delegate] window];
    } else {
        if (@available(iOS 13.0, *)) {
            NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
            UIWindowScene *windowScene = (UIWindowScene *) array[0];
            UIWindow *mainWindow = [windowScene valueForKeyPath:@"delegate.window"];
            if (mainWindow) {
                return mainWindow;
            } else {
                return [UIApplication sharedApplication].windows.lastObject;
            }
        } else {
            return [UIApplication sharedApplication].keyWindow;
        }
    }
}

@end
