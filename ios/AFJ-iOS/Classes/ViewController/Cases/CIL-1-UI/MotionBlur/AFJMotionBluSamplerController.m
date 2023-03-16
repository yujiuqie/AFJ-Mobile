//
//  AFJMotionBluSamplerController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/24.
//

#import "AFJMotionBluSamplerController.h"
#import "UIView+MotionBlur.h"

@interface AFJMotionBluSamplerController ()
@property (weak, nonatomic) IBOutlet UIImageView *topMenu;
// strong, because we'll be deactivating it, so view will stop referencing it
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topMenuHiddenConstraint;
@property (weak, nonatomic) IBOutlet UIButton *toggleButton;
@end

@implementation AFJMotionBluSamplerController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.toggleButton setTitle:@"Creating motion blurred layer…" forState:UIControlStateNormal];
    self.toggleButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    __weak typeof(self)weakSelf = self;
    [self.topMenu enableBlurWithAngle:M_PI_2 completion:^{
        [weakSelf.toggleButton setTitle:@"Toggle" forState:UIControlStateNormal];
        weakSelf.toggleButton.enabled = YES;
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [self.topMenu disableBlur];
}

- (IBAction)move:(UIButton *)sender
{
    self.topMenuHiddenConstraint.constant = self.topMenuHiddenConstraint.constant == -20 ? -800 : -20;

    BOOL hiding = self.topMenuHiddenConstraint.constant == -800;

    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:hiding ? 0.0 : 0.6
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{

                         [self.topMenu.superview layoutIfNeeded];
                         self.view.backgroundColor = hiding ? [UIColor colorWithWhite:0.907 alpha:1.000] : [UIColor colorWithWhite:0.8 alpha:1.000];
;

    } completion:nil];
}

@end
