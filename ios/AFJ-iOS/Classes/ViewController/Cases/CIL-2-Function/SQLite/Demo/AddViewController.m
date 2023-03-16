//
//  AddViewController.m
//  AFJ-iOS
//
//  Created by viktyz on 2022/8/25.
//

#import "AddViewController.h"
#import "DatabaseManager.h"
#import "UserModel.h"

@interface AddViewController () {
    DatabaseManager *manager;
}

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:160.0 / 255
                                                green:255.0 / 255
                                                 blue:234.0 / 255 alpha:1];

    manager = [DatabaseManager shareManager];


}

- (void)changeNavBarStyle {
    NSDictionary *attribute = @{
            NSForegroundColorAttributeName: [UIColor whiteColor]
    };
    self.navigationController.navigationBar.backgroundColor = [UIColor greenColor];
    self.navigationController.navigationBar.titleTextAttributes = attribute;
}

- (IBAction)addDatabase:(id)sender {
    _model = [[UserModel alloc] init];
    self.model.username = _usernameLabel.text;
    self.model.password = _passwordLabel.text;
    self.model.age = [_ageLabel.text intValue];
//
    [manager addUserModel:_model];

    [self changeNavBarStyle];

    [self.navigationController popViewControllerAnimated:YES];


}
@end
