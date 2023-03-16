//
//  SafeCenterButton.m
//  OCDemol
//
//  Created by 冯汉栩 on 2020/5/28.
//  Copyright © 2020 com.fenghanxu.demol. All rights reserved.
//

@interface SafeCenterButton () {
    //是否移动了，移动了取消点击事件
    CGFloat moveStepX;
    CGFloat moveStepY;
    CGFloat minTop;
    CGFloat maxTop;
}
@end

@implementation SafeCenterButton

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

- (instancetype)init {
    CGFloat bottom = 100 + 38;
    if (IPhoneX) {
        bottom += 20;
    }
    return [self initWithImage:@"safecenter_main" top:statusHight bottom:bottom frame:CGRectMake(0, Phone_Height - bottom, 110, 38)];
}

- (instancetype)initWithImage:(NSString *)name top:(CGFloat)top bottom:(CGFloat)bottom frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        minTop = top;
        maxTop = Phone_Height - bottom;
        self.frame = frame;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        imageView.frame = self.bounds;
        [self addSubview:imageView];
    }
    return self;
}

- (void)presentToSafeCenter {
    if ([self.delegate respondsToSelector:@selector(safeCenterButton:btnClick:)]) {
        [self.delegate safeCenterButton:self btnClick:[NSString new]];
    }
}

- (void)moveToDefaultPosition {
    CGRect frame = self.frame;
    if (frame.origin.x <= (Phone_Width - frame.size.width) / 2) {
        frame.origin.x = 0;
    } else {
        frame.origin.x = Phone_Width - frame.size.width;
    }
    if (frame.origin.y < minTop) {
        frame.origin.y = minTop;
    } else if (frame.origin.y > maxTop) {
        frame.origin.y = maxTop;
    }
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = frame;
    }];
    if ([self.delegate respondsToSelector:@selector(safeCenterButton:btnFrame:)]) {
        [self.delegate safeCenterButton:self btnFrame:frame];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    moveStepX = 0;
    moveStepY = 0;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (fabs(moveStepX) < 1 && fabs(moveStepY) < 1) {
        [self presentToSafeCenter];
    }
    __weak typeof(self) weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.1 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [weakSelf moveToDefaultPosition];
    });
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    if (@available(iOS 9.1, *)) {
        CGPoint previousPoint = [touch precisePreviousLocationInView:self];
        CGFloat offsetX = currentPoint.x - previousPoint.x;
        CGFloat offsetY = currentPoint.y - previousPoint.y;
//        NSLog(@"%f  %f", offsetX, offsetY);
        moveStepX += offsetX;
        moveStepY += offsetY;
        self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
    } else {

    }
}

@end


