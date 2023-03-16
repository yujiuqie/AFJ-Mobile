//
//  AFJLogTableViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/22.
//

#import "AFJLogTableViewController.h"

NSString *const kAFJLogCellIdentifier = @"AFJLogCell";

@interface AFJLogTableViewController ()

@end

@implementation AFJLogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // we use a nib which contains the cell's view and this class as the files owner
    [self.tableView registerNib:[UINib nibWithNibName:@"AFJLogCell" bundle:nil] forCellReuseIdentifier:kAFJLogCellIdentifier];
    self.tableView.estimatedRowHeight = 11;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)configureCell:(AFJLogCell *)cell forProduct:(AFJLog *)log {
    cell.logLabel.text = log.title;
}

@end
