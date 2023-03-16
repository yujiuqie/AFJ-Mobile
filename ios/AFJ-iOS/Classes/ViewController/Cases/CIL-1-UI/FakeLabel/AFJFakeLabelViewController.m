//
//  AFJFakeLabelViewController.m
//  AFJ-iOS
//
//  Created by viktyz on 2022/8/25.
//

#import "AFJFakeLabelViewController.h"
#import "UILabel+STFakeAnimation.h"

@interface AFJFakeLabelViewController ()

@property(weak, nonatomic) IBOutlet UILabel *fakeLabel;

@end

@implementation AFJFakeLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)buttonTapped:(UIButton *)sender {

    NSInteger tag = sender.tag;
    static int flag = 0;
    NSString *toText = flag % 2 ? @"EGG" : @"FALL";
    flag++;

    if (tag == 100) {
        [self.fakeLabel st_startAnimationWithDirection:STFakeAnimationDown toText:toText];
        return;
    }
    if (tag == 101) {
        [self.fakeLabel st_startAnimationWithDirection:STFakeAnimationLeft toText:toText];
        return;
    }
    if (tag == 102) {
        [self.fakeLabel st_startAnimationWithDirection:STFakeAnimationRight toText:toText];
        return;
    }
    if (tag == 103) {
        [self.fakeLabel st_startAnimationWithDirection:STFakeAnimationUp toText:toText];
        return;
    }
}

@end
