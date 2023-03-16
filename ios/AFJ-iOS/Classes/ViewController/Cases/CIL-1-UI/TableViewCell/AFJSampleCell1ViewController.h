//
//  AFJSampleCell1ViewController.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/22.
//

#import "AFJRootViewController.h"
#import "MGSwipeTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJSampleCell1ViewController : AFJRootViewController<UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate, UIActionSheetDelegate>

@property (nonatomic, assign) BOOL testingStoryboardCell;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
