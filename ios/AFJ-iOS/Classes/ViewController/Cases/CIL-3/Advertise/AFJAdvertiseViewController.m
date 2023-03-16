//
//  AFJAdvertiseViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/7.
//

#import "AFJAdvertiseViewController.h"
#import "OnboardingViewController.h"
#import "OnboardingContentViewController.h"

@interface AFJAdvertiseViewController ()


@property(nonatomic, strong) OnboardingViewController *obVC;

@end

@implementation AFJAdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"启动广告倒计时示例";
        item.didSelectAction = ^(id data) {
            [AdvertiseCountDownNsObject initAdvertise:@[
                    @"http://101.132.129.63:8081/usr/uploads/2022/08/67638669.jpg",
                    @"http://101.132.129.63:8081/usr/uploads/2022/04/1672282573.jpeg",
                    @"http://101.132.129.63:8081/usr/uploads/2022/04/2528611222.jpeg",
                    @"http://101.132.129.63:8081/usr/uploads/2022/04/1069431224.jpeg",
                    @"http://101.132.129.63:8081/usr/uploads/2022/04/497515783.jpeg",
                    @"http://101.132.129.63:8081/usr/uploads/2022/08/67638669.jpg"
            ]];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"启动广告渐变示例";
        item.didSelectAction = ^(id data) {
            [AdvertiseGradientNSObject initAdvertise:@[
                    @"http://101.132.129.63:8081/usr/uploads/2022/08/67638669.jpg",
                    @"http://101.132.129.63:8081/usr/uploads/2022/04/1672282573.jpeg",
                    @"http://101.132.129.63:8081/usr/uploads/2022/04/2528611222.jpeg",
                    @"http://101.132.129.63:8081/usr/uploads/2022/04/1069431224.jpeg",
                    @"http://101.132.129.63:8081/usr/uploads/2022/04/497515783.jpeg",
                    @"http://101.132.129.63:8081/usr/uploads/2022/08/67638669.jpg"
            ]];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"启动引导示例一";
        item.didSelectAction = ^(id data) {
            weakSelf.obVC = [weakSelf generateStandardOnboardingVC];
            [weakSelf presentViewController:weakSelf.obVC animated:YES completion:nil];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"启动引导示例二";
        item.didSelectAction = ^(id data) {
            weakSelf.obVC = [weakSelf generateMovieOnboardingVC];
            [weakSelf presentViewController:weakSelf.obVC animated:YES completion:nil];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"启动引导示例三";
        item.didSelectAction = ^(id data) {
            weakSelf.obVC = [weakSelf generateContentVideoOnboardingVC];
            [weakSelf presentViewController:weakSelf.obVC animated:YES completion:nil];
        };
        [dataArray addObject:item];
    }
        self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (OnboardingViewController *)generateStandardOnboardingVC {
    OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"What A Beautiful Photo" body:@"This city background image is so beautiful." image:[UIImage imageNamed:@"blue"] buttonText:@"Enable Location Services" action:^{
        [[[UIAlertView alloc] initWithTitle:nil message:@"Here you can prompt users for various application permissions, providing them useful information about why you'd like those permissions to enhance their experience, increasing your chances they will grant those permissions." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    
    OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"I'm so sorry" body:@"I can't get over the nice blurry background photo." image:[UIImage imageNamed:@"red"] buttonText:@"Connect With Facebook" action:^{
        [[[UIAlertView alloc] initWithTitle:nil message:@"Prompt users to do other cool things on startup. As you can see, hitting the action button on the prior page brought you automatically to the next page. Cool, huh?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    secondPage.movesToNextViewController = YES;
    secondPage.viewDidAppearBlock = ^{
        [[[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"You've arrived on the second page, and this alert was displayed from within the page's viewDidAppearBlock." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    };
    
    OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"Seriously Though" body:@"Kudos to the photographer." image:[UIImage imageNamed:@"yellow"] buttonText:@"Get Started" action:^{
        [self handleOnboardingCompletion];
    }];
    
    OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"street"] contents:@[firstPage, secondPage, thirdPage]];
    onboardingVC.shouldFadeTransitions = YES;
    onboardingVC.fadePageControlOnLastPage = YES;
    onboardingVC.fadeSkipButtonOnLastPage = YES;

    // If you want to allow skipping the onboarding process, enable skipping and set a block to be executed
    // when the user hits the skip button.
    onboardingVC.allowSkipping = YES;
    onboardingVC.modalPresentationStyle = UIModalPresentationFullScreen;
    onboardingVC.skipHandler = ^{
        [self handleOnboardingCompletion];
    };
    
    return onboardingVC;
}

- (OnboardingViewController *)generateMovieOnboardingVC {
    OnboardingContentViewController *firstPage = [[OnboardingContentViewController alloc] initWithTitle:@"Everything Under The Sun" body:@"The temperature of the photosphere is over 10,000°F." image:nil buttonText:nil action:nil];
    firstPage.topPadding = -15;
    firstPage.underTitlePadding = 160;
    firstPage.titleLabel.textColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    firstPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    firstPage.bodyLabel.textColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    firstPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:18.0];
    
    OnboardingContentViewController *secondPage = [[OnboardingContentViewController alloc] initWithTitle:@"Every Second" body:@"600 million tons of protons are converted into helium atoms." image:nil buttonText:nil action:nil];
    secondPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    secondPage.underTitlePadding = 170;
    secondPage.topPadding = 0;
    secondPage.titleLabel.textColor = [UIColor colorWithRed:251/255.0 green:176/255.0 blue:59/255.0 alpha:1.0];
    secondPage.bodyLabel.textColor = [UIColor colorWithRed:251/255.0 green:176/255.0 blue:59/255.0 alpha:1.0];
    secondPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:18.0];
    
    OnboardingContentViewController *thirdPage = [[OnboardingContentViewController alloc] initWithTitle:@"We're All Star Stuff" body:@"Our very bodies consist of the same chemical elements found in the most distant nebulae, and our activities are guided by the same universal rules." image:nil buttonText:@"Explore the universe" action:^{
        [self handleOnboardingCompletion];
    }];
    thirdPage.topPadding = 10;
    thirdPage.underTitlePadding = 160;
    thirdPage.bottomPadding = -10;
    thirdPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    thirdPage.titleLabel.textColor = [UIColor colorWithRed:58/255.0 green:105/255.0 blue:136/255.0 alpha:1.0];
    thirdPage.bodyLabel.textColor = [UIColor colorWithRed:58/255.0 green:105/255.0 blue:136/255.0 alpha:1.0];
    thirdPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:15.0];
    [thirdPage.actionButton setTitleColor:[UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0] forState:UIControlStateNormal];
    thirdPage.actionButton.titleLabel.font = [UIFont fontWithName:@"SpaceAge" size:17.0];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"sun" ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
    
    OnboardingViewController *onboardingVC = [[OnboardingViewController alloc] initWithBackgroundVideoURL:movieURL contents:@[firstPage, secondPage, thirdPage]];
    onboardingVC.shouldFadeTransitions = YES;
    onboardingVC.shouldMaskBackground = NO;
    onboardingVC.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    onboardingVC.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    onboardingVC.modalPresentationStyle = UIModalPresentationFullScreen;
    return onboardingVC;
}

- (OnboardingViewController *)generateContentVideoOnboardingVC {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"sun" ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];

    OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"Everything Under The Sun" body:@"The temperature of the photosphere is over 10,000°F." videoURL:movieURL buttonText:nil action:nil];
    firstPage.topPadding = -15;
    firstPage.underTitlePadding = 160;
    firstPage.titleLabel.textColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    firstPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    firstPage.bodyLabel.textColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    firstPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:18.0];

    OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"Every Second" body:@"600 million tons of protons are converted into helium atoms." videoURL:movieURL buttonText:nil action:nil];
    secondPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    secondPage.underTitlePadding = 170;
    secondPage.topPadding = 0;
    secondPage.titleLabel.textColor = [UIColor colorWithRed:251/255.0 green:176/255.0 blue:59/255.0 alpha:1.0];
    secondPage.bodyLabel.textColor = [UIColor colorWithRed:251/255.0 green:176/255.0 blue:59/255.0 alpha:1.0];
    secondPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:18.0];

    OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"We're All Star Stuff" body:@"Our very bodies consist of the same chemical elements found in the most distant nebulae, and our activities are guided by the same universal rules." videoURL:movieURL buttonText:@"OK" action:^{
        [self handleOnboardingCompletion];
    }];
    thirdPage.topPadding = 10;
    thirdPage.underTitlePadding = 160;
    thirdPage.bottomPadding = -10;
    thirdPage.titleLabel.font = [UIFont fontWithName:@"SFOuterLimitsUpright" size:38.0];
    thirdPage.titleLabel.textColor = [UIColor colorWithRed:58/255.0 green:105/255.0 blue:136/255.0 alpha:1.0];
    thirdPage.bodyLabel.textColor = [UIColor colorWithRed:58/255.0 green:105/255.0 blue:136/255.0 alpha:1.0];
    thirdPage.bodyLabel.font = [UIFont fontWithName:@"NasalizationRg-Regular" size:15.0];
    [thirdPage.actionButton setTitleColor:[UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0] forState:UIControlStateNormal];
    thirdPage.actionButton.titleLabel.font = [UIFont fontWithName:@"SpaceAge" size:17.0];

    OnboardingViewController *onboardingVC = [[OnboardingViewController alloc] initWithBackgroundImage:nil contents:@[firstPage, secondPage, thirdPage]];
    onboardingVC.view.backgroundColor = [UIColor blackColor];
    onboardingVC.shouldFadeTransitions = YES;
    onboardingVC.shouldMaskBackground = NO;
    onboardingVC.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:239/255.0 green:88/255.0 blue:35/255.0 alpha:1.0];
    onboardingVC.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    onboardingVC.modalPresentationStyle = UIModalPresentationFullScreen;
    return onboardingVC;
}

- (void)handleOnboardingCompletion {
    // set that we have completed onboarding so we only do it once... for demo
    // purposes we don't want to have to set this every time so I'll just leave
    // this here...
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserHasOnboardedKey];
    
    // transition to the main application
//    [self setupNormalRootViewController];
    [self.obVC dismissViewControllerAnimated:YES completion:nil];
}

@end
