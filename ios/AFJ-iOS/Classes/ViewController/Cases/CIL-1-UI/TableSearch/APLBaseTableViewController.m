/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Base or common view controller to share a common UITableViewCell prototype between subclasses.
 */

#import "APLBaseTableViewController.h"
#import "APLProduct.h"
#import "APLProductCell.h"

NSString *const kCellIdentifier = @"cellID";
NSString *const kTableCellNibName = @"TableCell";

@implementation APLBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[APLProductCell class] forCellReuseIdentifier:kCellIdentifier];
    self.tableView.estimatedRowHeight = 60;
}

- (void)configureCell:(UITableViewCell *)cell forProduct:(APLProduct *)product {
    cell.textLabel.text = product.title;
    cell.textLabel.numberOfLines = 0;

    // build the price and year string
    // use NSNumberFormatter to get the currency format out of this NSNumber (product.introPrice)
    //
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    NSString *priceString = [numberFormatter stringFromNumber:product.introPrice];

    NSString *detailedStr = [NSString stringWithFormat:@"%@ | %@", priceString, (product.yearIntroduced).stringValue];
    cell.detailTextLabel.text = detailedStr;
}

@end
