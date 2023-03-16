//
//  AFJBTCentralModeViewController.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/23.
//

#import "AFJRootViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BabyBluetooth.h"
#import "PeripheralViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJBTCentralModeViewController : AFJRootListViewController
<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
