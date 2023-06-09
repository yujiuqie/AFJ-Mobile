//
//  UIViewController+StoreKit.m
//  Picks
//
//  Created by Joe Fabisevich on 8/12/14.
//  Copyright (c) 2014 Snarkbots. All rights reserved.
//

#import "UIViewController+JKStoreKit.h"
#import <objc/runtime.h>
#import <StoreKit/StoreKit.h>

static NSString * const kAffiliateTokenKey = @"at";
static NSString * const kCampaignTokenKey = @"ct";
static NSString * const KiTunesAppleString = @"itunes.apple.com";

@interface UIViewController (SKStoreProductViewControllerDelegate) <SKStoreProductViewControllerDelegate>
@end

#pragma mark - Implementation

@implementation UIViewController (JKStoreKit)

- (void)jk_presentStoreKitItemWithIdentifier:(NSInteger)itemIdentifier
{
    SKStoreProductViewController* storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;

    NSString* campaignToken = self.jk_campaignToken ?: @"";

    NSDictionary* parameters = @{
        SKStoreProductParameterITunesItemIdentifier : @(itemIdentifier),
        kAffiliateTokenKey : kAffiliateTokenKey,
        kCampaignTokenKey : campaignToken,
    };

    if (self.jk_loadingStoreKitItemBlock) {
        self.jk_loadingStoreKitItemBlock();
    }
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError* error) {
        if (self.jk_loadedStoreKitItemBlock) {
            self.jk_loadedStoreKitItemBlock();
        }

        if (result && !error)
        {
            [self presentViewController:storeViewController animated:YES completion:nil];
        }
    }];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Delegation - SKStoreProductViewControllerDelegate

- (void)jk_productViewControllerDidFinish:(SKStoreProductViewController*)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

+ (NSURL*)jk_appURLForIdentifier:(NSInteger)identifier
{
    NSString* appURLString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%li", (long)identifier];
    return [NSURL URLWithString:appURLString];
}

+ (void)jk_openAppReviewURLForIdentifier:(NSInteger)identifier
{
    NSString *reviewURLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%li", (long)identifier];
    
    NSURL *reviewURL = [NSURL URLWithString:reviewURLString];
    BOOL canOpenReviewURL = [[UIApplication sharedApplication] canOpenURL:reviewURL];
    if (!canOpenReviewURL) { return; }
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:reviewURL options:@{} completionHandler:nil];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [[UIApplication sharedApplication] openURL:reviewURL];
#pragma clang diagnostic pop
    }
}

+ (void)jk_openAppURLForIdentifier:(NSInteger)identifier
{
    NSString *appURLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%li", (long)identifier];
    
    NSURL *appURL = [NSURL URLWithString:appURLString];
    BOOL canOpenAppURL = [[UIApplication sharedApplication] canOpenURL:appURL];
    if (!canOpenAppURL) { return; }
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:appURL options:@{} completionHandler:nil];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [[UIApplication sharedApplication] openURL:appURL];
#pragma clang diagnostic pop
    }
}

+ (BOOL)jk_containsITunesURLString:(NSString*)URLString
{
    return ([URLString rangeOfString:KiTunesAppleString].location != NSNotFound);
}

+ (NSInteger)jk_IDFromITunesURL:(NSString*)URLString
{
    NSError* error;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"id\\d+" options:0 error:&error];
    NSTextCheckingResult* match = [regex firstMatchInString:URLString options:0 range:NSMakeRange(0, URLString.length)];

    NSString* idString = [URLString substringWithRange:match.range];
    if (idString.length > 0) {
        idString = [idString stringByReplacingOccurrencesOfString:@"id" withString:@""];
    }

    return [idString integerValue];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Associated objects

- (void)setJk_campaignToken:(NSString*)campaignToken
{
    objc_setAssociatedObject(self, @selector(setJk_campaignToken:), campaignToken, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*)jk_campaignToken
{
    return objc_getAssociatedObject(self, @selector(setJk_campaignToken:));
}

- (void)setJk_loadingStoreKitItemBlock:(void (^)(void))loadingStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setJk_loadingStoreKitItemBlock:), loadingStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))jk_loadingStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setJk_loadingStoreKitItemBlock:));
}

- (void)setJk_loadedStoreKitItemBlock:(void (^)(void))loadedStoreKitItemBlock
{
    objc_setAssociatedObject(self, @selector(setJk_loadedStoreKitItemBlock:), loadedStoreKitItemBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))jk_loadedStoreKitItemBlock
{
    return objc_getAssociatedObject(self, @selector(setJk_loadedStoreKitItemBlock:));
}

@end
