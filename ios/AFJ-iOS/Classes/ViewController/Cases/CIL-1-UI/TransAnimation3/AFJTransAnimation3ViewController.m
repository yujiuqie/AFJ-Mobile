//
//  AFJTransAnimation3ViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/26.
//

#import "AFJTransAnimation3ViewController.h"

#import "AFJCaseItemData.h"
#import "TTMDetailViewController.h"
#import "HUTransitionAnimator.h"
#import "ATCAnimatedTransitioning.h"
#import "ATCAnimatedTransitioningFade.h"
#import "ATCAnimatedTransitioningBounce.h"
#import "LCZoomTransition.h"
#import "CEReversibleAnimationController.h"
#import "ADTransitionController.h"
#import "KWTransitionHelper.h"
#import "DMBaseTransition.h"
#import "HFAnimator.h"
#import "HFDynamicAnimator.h"
#import "FlipTransition.h"
#import "CoreImageTransition.h"
#import "CoreImageBlurTransition.h"
#import "CoreImageMotionBlurTransition.h"

#define kClassNameForCoreImageTransition @"CoreImageTransition"

@interface AFJTransAnimation3ViewController()
<UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *transitionClassName;
@property (nonatomic, strong) id animator;


@end

@implementation AFJTransAnimation3ViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.tableView.bounds];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = backgroundView.bounds;
    UIColor *startColor = [UIColor colorWithRed: 90./255.
                                          green:200./255.
                                           blue:251./255.
                                          alpha:1.0];
    UIColor *endColor   = [UIColor colorWithRed: 82./255.
                                          green:237./255.
                                           blue:199./255.
                                          alpha:1.0];
    
    gradient.colors = @[(id)startColor.CGColor, (id)endColor.CGColor];
    [backgroundView.layer addSublayer:gradient];
    self.tableView.backgroundView = backgroundView;
    
    [self.view addSubview:self.tableView];
    
    self.navigationController.delegate = self;
    
    self.items = @[
                   @"HUTransitionVerticalLinesAnimator",
                   @"HUTransitionHorizontalLinesAnimator",
                   @"HUTransitionGhostAnimator",
                   @"ZBFallenBricksAnimator",
                   [NSString stringWithFormat:@"%@%@", kClassNameForCoreImageTransition, kCoreImageTransitionTypeNameBoxBlur],
                   [NSString stringWithFormat:@"%@%@", kClassNameForCoreImageTransition, kCoreImageTransitionTypeNameMotionBlur],
                   [NSString stringWithFormat:@"%@%@", kClassNameForCoreImageTransition, kCoreImageTransitionTypeNameCopyMachine],
                   [NSString stringWithFormat:@"%@%@", kClassNameForCoreImageTransition, kCoreImageTransitionTypeNameDisintegrateWithMask],
                   [NSString stringWithFormat:@"%@%@", kClassNameForCoreImageTransition, kCoreImageTransitionTypeNameDissolve],
                   [NSString stringWithFormat:@"%@%@", kClassNameForCoreImageTransition, kCoreImageTransitionTypeNameFlash],
                   [NSString stringWithFormat:@"%@%@", kClassNameForCoreImageTransition, kCoreImageTransitionTypeNameMod],
                   [NSString stringWithFormat:@"%@%@", kClassNameForCoreImageTransition, kCoreImageTransitionTypeNamePageCurl],
                   [NSString stringWithFormat:@"%@%@", kClassNameForCoreImageTransition, kCoreImageTransitionTypeNamePageCurlWithShadow],
                   [NSString stringWithFormat:@"%@%@", kClassNameForCoreImageTransition, kCoreImageTransitionTypeNameRipple],
                   [NSString stringWithFormat:@"%@%@", kClassNameForCoreImageTransition, kCoreImageTransitionTypeNameSwipe],
                   @"ATCAnimatedTransitioningFade",
                   @"ATCAnimatedTransitioningBounce",
                   @"ATCAnimatedTransitioningSquish",
                   @"ATCAnimatedTransitioningFloat",
                   @"LCZoomTransition",
                   @"ADBackFadeTransition",
                   @"ADCarrouselTransition",
                   @"ADCrossTransition",
                   @"ADCubeTransition",
                   @"ADFadeTransition",
                   @"ADFlipTransition",
                   @"ADFoldTransition",
                   @"ADGhostTransition",
                   @"ADGlueTransition",
                   @"ADModernPushTransition",
                   @"ADPushRotateTransition",
                   @"ADScaleTransition",
                   @"ADSlideTransition",
                   @"ADSwapTransition",
                   @"ADSwipeFadeTransition",
                   @"ADSwipeTransition",
                   @"ADZoomTransition",
                   @"CECardsAnimationController",
                   @"CECrossfadeAnimationController",
                   @"CECubeAnimationController",
                   @"CEExplodeAnimationController",
                   @"CEFlipAnimationController",
                   @"CEFoldAnimationController",
                   @"CENatGeoAnimationController",
                   @"CEPanAnimationController",
                   @"CEPortalAnimationController",
                   @"CETurnAnimationController",
                   KWTransitionStyleNameRotateFromTop,
                   KWTransitionStyleNameFadeBackOver,
                   KWTransitionStyleNameBounceIn,
                   KWTransitionStyleNameDropOut,
                   KWTransitionStyleNameStepBackScroll,
                   KWTransitionStyleNameStepBackSwipe,
                   KWTransitionStyleNameUp,
                   KWTransitionStyleNamePushUp,
                   KWTransitionStyleNameFall,
                   KWTransitionStyleNameSink,
                   @"DMAlphaTransition",
                   @"DMScaleTransition",
                   @"DMSlideTransition",
                   @"HFAnimator",
                   @"HFDynamicAnimator",
                   @"BouncePresentTransition",
                   @"FlipTransition",
                   @"ShrinkDismissTransition",
                   ];
    
    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSString *aniName in _items) {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = aniName;
        item.didSelectAction = ^(id data) {
            weakSelf.transitionClassName = aniName;
            TTMDetailViewController *vc = [[TTMDetailViewController alloc] initWithNibName:@"TTMDetailViewController" bundle:nil];
            [vc setDetailItem:aniName];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

#pragma mark -

// =============================================================================
#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    self.animator = nil;

    if (NSClassFromString(self.transitionClassName)) {
        
        Class aClass = NSClassFromString(self.transitionClassName);
        self.animator = [[aClass alloc] init];
    }
    // only for KWTransition
    else if ([self.transitionClassName hasPrefix:@"KWTransition"]) {
        
        KWTransition *transition = [[KWTransition alloc] init];
        transition.style = [KWTransitionHelper styleForTransitionName:self.transitionClassName];

        self.animator = transition;
    }
    // only for CoreImageTransition
    else if ([self.transitionClassName hasPrefix:kClassNameForCoreImageTransition]) {

        NSString *typeName = [self.transitionClassName stringByReplacingOccurrencesOfString:kClassNameForCoreImageTransition
                                                                                 withString:@""];
        
        CoreImageTransition *transition;
        if (
            [typeName isEqualToString:kCoreImageTransitionTypeNameBoxBlur] ||
            [typeName isEqualToString:kCoreImageTransitionTypeNameDiscBlur] ||
            [typeName isEqualToString:kCoreImageTransitionTypeNameGaussianBlur]
            )
        {
            transition = [CoreImageBlurTransition new];
        }
        else if ([typeName isEqualToString:kCoreImageTransitionTypeNameMotionBlur])
        {
            transition = [CoreImageMotionBlurTransition new];
        }
        else
        {
            transition = [CoreImageTransition new];
        }
        [transition setTransitionTypeWithName:typeName];
        
        self.animator = transition;
    }
    
    if (self.animator) {

        [self setupAnimatorForOperation:operation];
    }
    
    return self.animator;
}


// =============================================================================
#pragma mark - Private

// setup for each OSS
- (void)setupAnimatorForOperation:(UINavigationControllerOperation)operation
{
    // HUAnimator
    // DMCustomTransitions
    if (
        [self.animator isKindOfClass:[CoreImageTransition class]] ||
        [self.animator isKindOfClass:[HUTransitionAnimator class]] ||
        [self.animator isKindOfClass:[DMBaseTransition class]] ||
        [self.animator isKindOfClass:[HFAnimator class]] ||
        [self.animator isKindOfClass:[HFDynamicAnimator class]]
        )
    {
        [self.animator setPresenting:(operation == UINavigationControllerOperationPush)];
    }
    // Animated-Transition-Collection
    else if ([self.animator isKindOfClass:[ATCAnimatedTransitioning class]]) {
        
        [((ATCAnimatedTransitioning *)self.animator) setDuration:1.0];
        [self.animator setIsPush:(operation != UINavigationControllerOperationPop)];
        
        if (![self.animator isKindOfClass:[ATCAnimatedTransitioningFade class]] &&
            ![self.animator isKindOfClass:[ATCAnimatedTransitioningBounce class]])
        {
            [self.animator setDismissal:(operation == UINavigationControllerOperationPop)];
        }
        
        if (operation == UINavigationControllerOperationPush) {
            
            [(ATCAnimatedTransitioning *)self.animator setDirection:ATCTransitionAnimationDirectionRight];
        }
        else {
            [(ATCAnimatedTransitioning *)self.animator setDirection:ATCTransitionAnimationDirectionLeft];
        }
    }
    // LCZoomTransition
    else if ([self.animator isKindOfClass:[LCZoomTransition class]]) {
        
        [(LCZoomTransition *)self.animator setTransitionDuration:0.5];
        [(LCZoomTransition *)self.animator setOperation:operation];
    }
    // VCTransitionsLibrary
    // FlipTransition
    else if ([self.animator isKindOfClass:[CEReversibleAnimationController class]] ||
             [self.animator isKindOfClass:[FlipTransition class]]) {
        
        [self.animator setReverse:(operation == UINavigationControllerOperationPop)];
    }
    // ADTransition
    else if ([self.animator isKindOfClass:[ADTransition class]]) {
        
        ADTransition *transition = self.animator;
        
        Class aClass = [transition class];
        
        if ([transition respondsToSelector:@selector(initWithDuration:orientation:sourceRect:)]) {
            
            transition = [[aClass alloc] initWithDuration:0.5f
                                              orientation:ADTransitionRightToLeft
                                               sourceRect:self.tableView.bounds];
        }
        else if ([transition respondsToSelector:@selector(initWithDuration:sourceRect:)]) {
            
            transition = [[aClass alloc] initWithDuration:0.5f
                                               sourceRect:self.tableView.bounds];
        }
        else {
            
            transition = [[aClass alloc] initWithDuration:0.5f];
        }
        
        self.animator = [[ADTransitioningDelegate alloc] initWithTransition:transition];
    }
    // KWTransition
    else if ([self.animator isKindOfClass:[KWTransition class]]) {
        
        if (operation == UINavigationControllerOperationPush) {
            
            [(KWTransition *)self.animator setAction:KWTransitionStepPresent];
        }
        else {
            [(KWTransition *)self.animator setAction:KWTransitionStepDismiss];
        }
        
        if ([(KWTransition *)self.animator style] == KWTransitionStyleSink) {
            [(KWTransition *)self.animator setSettings:KWTransitionSettingDirectionDown];
        }
    }
}


@end
