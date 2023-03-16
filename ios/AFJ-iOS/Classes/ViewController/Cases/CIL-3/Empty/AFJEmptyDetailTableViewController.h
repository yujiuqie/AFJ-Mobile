//
//  AFJEmptyDetailTableViewController.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/22.
//

#import <UIKit/UIKit.h>
#import "Application.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJEmptyDetailTableViewController : UITableViewController

@property (nonatomic, weak) NSArray *applications;
@property (nonatomic) BOOL allowShuffling;

- (instancetype)initWithApplication:(Application *)app;

@end

NS_ASSUME_NONNULL_END
