//
//  UpdatViewController.h
//  AFJ-iOS
//
//  Created by viktyz on 2022/8/25.
//

#import "AFJRootViewController.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdatViewController : AFJRootListViewController

@property(weak, nonatomic) IBOutlet UITextField *usernameTF;
@property(weak, nonatomic) IBOutlet UITextField *passwordTF;
@property(weak, nonatomic) IBOutlet UITextField *ageTF;

@property(nonatomic, strong) UserModel *model;

@end

NS_ASSUME_NONNULL_END
