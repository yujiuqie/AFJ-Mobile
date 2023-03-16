//
//  AddViewController.h
//  AFJ-iOS
//
//  Created by viktyz on 2022/8/25.
//

#import "AFJRootViewController.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : AFJRootListViewController

@property(weak, nonatomic) IBOutlet UITextField *usernameLabel;

@property(weak, nonatomic) IBOutlet UITextField *passwordLabel;

@property(weak, nonatomic) IBOutlet UITextField *ageLabel;

@property(nonatomic, strong) UserModel *model;

@end

NS_ASSUME_NONNULL_END
