/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The detail view controller navigated to from our main and results table.
 */

#import "APLDetailViewController.h"
#import "APLProduct.h"

@interface APLDetailViewController ()

@property(nonatomic, strong) UILabel *yearLabel;
@property(nonatomic, strong) UILabel *priceLabel;

@end


#pragma mark -

@implementation APLDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.product.title;

    self.yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 500, 80)];
    [self.view addSubview:_yearLabel];
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, 500, 80)];
    [self.view addSubview:_priceLabel];

    self.yearLabel.text = (self.product.yearIntroduced).stringValue;

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    NSString *priceString = [numberFormatter stringFromNumber:self.product.introPrice];
    self.priceLabel.text = priceString;

    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UIStateRestoration

NSString *const APLViewControllerProductKey = @"APLViewControllerProductKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];

    // encode the product
    [coder encodeObject:self.product forKey:APLViewControllerProductKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];

    // restore the product
    self.product = [coder decodeObjectForKey:APLViewControllerProductKey];
}

@end



