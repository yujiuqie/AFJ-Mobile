//
//  AFJLogResultsTableController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/22.
//

#import "AFJLogResultsTableController.h"
#import "AFJLog.h"

@interface AFJLogResultsTableController ()

@end

@implementation AFJLogResultsTableController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredLogs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *) [self.tableView dequeueReusableCellWithIdentifier:kAFJLogCellIdentifier];

    AFJLog *log = self.filteredLogs[indexPath.row];
    [self configureCell:cell forProduct:log];

    return cell;
}

@end
