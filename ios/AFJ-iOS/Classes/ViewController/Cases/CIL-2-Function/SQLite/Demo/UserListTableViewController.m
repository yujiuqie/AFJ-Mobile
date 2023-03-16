//
//  UserListTableViewController.m
//  AFJ-iOS
//
//  Created by viktyz on 2022/8/25.
//

#import "UserListTableViewController.h"
#import "DatabaseManager.h"
#import "UserModel.h"
#import "CustomCell.h"
#import "UpdatViewController.h"
#import "AddViewController.h"

@interface UserListTableViewController () {

    DatabaseManager *manager;
    NSArray *dataArr;
    UILabel *usernameLabel;
    UILabel *ageLabel;
}

@property(weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation UserListTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    self reFreshData:<#(id)#>
    dataArr = [manager queryAllModel];
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor colorWithRed:234.0 / 255
                                                     green:194.0 / 255
                                                      blue:234.0 / 255 alpha:1];
    [self changeNavBarStyle];
    manager = [DatabaseManager shareManager];

    dataArr = [manager queryAllModel];
}

- (void)changeNavBarStyle {

    NSDictionary *attribute = @{
            NSForegroundColorAttributeName: [UIColor whiteColor]
    };
    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
    self.navigationController.navigationBar.titleTextAttributes = attribute;

}

- (IBAction)reFreshData:(id)sender {

    dataArr = [manager queryAllModel];
    [self.tableView reloadData];

}

- (IBAction)clickAddAction:(UIBarButtonItem *)sender {
    AddViewController *addVC = [[AddViewController alloc] initWithNibName:@"AddViewController" bundle:nil];
    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    CustomCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil] lastObject];

    UserModel *model = dataArr[indexPath.row];
    cell.model = model;

    cell.backgroundColor = [UIColor colorWithRed:234.0 / 255
                                           green:194.0 / 255
                                            blue:234.0 / 255 alpha:1];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UserModel *model = dataArr[indexPath.row];

    UpdatViewController *updataVC = [[UpdatViewController alloc] initWithNibName:@"UpdatViewController" bundle:nil];
    updataVC.model = model;

    [self.navigationController pushViewController:updataVC animated:YES];
}

@end
