//
//  UserListTableViewController.h
//  AFJ-iOS
//
//  Created by viktyz on 2022/8/25.
//

#import "AFJRootViewController.h"
#import "UpdatViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserListTableViewController : AFJRootListViewController
        <
        UITableViewDataSource,
        UITableViewDelegate
        >

@property(nonatomic, strong) UpdatViewController *updateVC;

@end

NS_ASSUME_NONNULL_END
