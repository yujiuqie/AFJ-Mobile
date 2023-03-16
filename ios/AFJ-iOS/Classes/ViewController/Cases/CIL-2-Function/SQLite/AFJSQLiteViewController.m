//
//  AFJSQLiteViewController.m
//  AFJ-iOS
//
//  Created by viktyz on 2022/8/25.
//

#import "AFJSQLiteViewController.h"
#import "UserListTableViewController.h"

@interface AFJSQLiteViewController ()

@end

@implementation AFJSQLiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UserListTableViewController *userList = [[UserListTableViewController alloc] initWithNibName:@"UserListTableViewController" bundle:nil];
    [self.view addSubview:userList.view];
    userList.view.frame = self.view.bounds;
}


@end
