//
//  UpdatViewController.m
//  AFJ-iOS
//
//  Created by viktyz on 2022/8/25.
//

#import "UpdatViewController.h"
#import "DatabaseManager.h"
#import "UserModel.h"

@interface UpdatViewController () {
    DatabaseManager *manager;
}

@end

@implementation UpdatViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    manager = [DatabaseManager shareManager];


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    _usernameTF.text = self.model.username;
    _passwordTF.text = self.model.password;
    _ageTF.text = [NSString stringWithFormat:@"%d", self.model.age];

}


- (IBAction)updateAction:(id)sender {

    UserModel *model = [[UserModel alloc] init];
    model.username = _usernameTF.text;
    model.password = _passwordTF.text;
    model.age = [_ageTF.text intValue];
    [manager updateUserModel:model];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setModel:(UserModel *)model {

    _model = model;
}

@end
