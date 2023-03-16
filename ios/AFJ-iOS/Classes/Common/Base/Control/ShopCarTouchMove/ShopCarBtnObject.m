//
//  ShowShopCarBtnNsObject.m
//  OCDemol
//
//  Created by 冯汉栩 on 2019/12/28.
//  Copyright © 2019 com.fenghanxu.demol. All rights reserved.
//

#import "ShopCarBtn.h"
#import "NerdyUI.h"

@interface ShopCarBtnObject ()

@property(nonatomic, strong) ShopCarBtn *cartBtn;
@property(nonatomic, strong) UIPanGestureRecognizer *panGesRecognizer;

@end

@implementation ShopCarBtnObject

- (void)setScount:(NSString *)count {
    _sCount = count;
    self.cartBtn.subTitleLabel.str(_sCount);
}

- (void)showBtn {
    self.cartBtn = [ShopCarBtn new];
    self.cartBtn.titleLabel.str(@"购物车").fnt(16);
    self.cartBtn.icon.img(@"show_shoppingCar_normal");
    self.cartBtn.subTitleLabel.str(@"0");
    self.cartBtn.addTo([GetVC getCurrentViewController].view).makeCons(^{
        make.left.equal.view([GetVC getCurrentViewController].view).constants(50);
        make.top.equal.view([GetVC getCurrentViewController].view).constants(150);
        make.width.height.equal.constants(80);
    }).onClick(^{
        NSLog(@"跳转购物车控制器");
    });
    self.panGesRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesRecognizer:)];
    [self.cartBtn addGestureRecognizer:self.panGesRecognizer];
}

- (void)onPanGesRecognizer:(UIPanGestureRecognizer *)ges {
    if (ges.state == UIGestureRecognizerStateChanged || ges.state == UIGestureRecognizerStateEnded) {
        //translationInView：获取到的是手指移动后，在相对坐标中的偏移量
        CGPoint offset = [ges translationInView:[GetVC getCurrentViewController].view];
        CGPoint center = CGPointMake(self.cartBtn.center.x + offset.x, self.cartBtn.center.y + offset.y);
        //判断横坐标是否超出屏幕
        if (center.x <= 25) {
            center.x = 25;
        } else if (center.x >= [GetVC getCurrentViewController].view.bounds.size.width - 25) {
            center.x = [GetVC getCurrentViewController].view.bounds.size.width - 25;
        }
        //判断纵坐标是否超出屏幕
        if (center.y <= statusHight + 64 + 25) {
            center.y = statusHight + 64 + 25;
        } else if (center.y >= [GetVC getCurrentViewController].view.bounds.size.height - 25) {
            center.y = [GetVC getCurrentViewController].view.bounds.size.height - 25;
        }
        [self.cartBtn setCenter:center];
        //设置位置
        [ges setTranslation:CGPointMake(0, 0) inView:[GetVC getCurrentViewController].view];
    }
}

- (void)removePanGestureRecognizer {
    if (self.panGesRecognizer) {
        [self.cartBtn removeGestureRecognizer:self.panGesRecognizer];
        self.panGesRecognizer = nil;
    }
}

- (void)dealloc {
    [self removePanGestureRecognizer];
}

@end


