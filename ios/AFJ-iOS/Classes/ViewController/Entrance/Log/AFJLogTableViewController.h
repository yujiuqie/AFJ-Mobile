//
//  AFJLogTableViewController.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/22.
//

#import <UIKit/UIKit.h>
#import "AFJLog.h"
#import "AFJLogCell.h"

extern NSString *const kAFJLogCellIdentifier;

@interface AFJLogTableViewController : UITableViewController

- (void)configureCell:(AFJLogCell *)cell forProduct:(AFJLog *)log;

@end


