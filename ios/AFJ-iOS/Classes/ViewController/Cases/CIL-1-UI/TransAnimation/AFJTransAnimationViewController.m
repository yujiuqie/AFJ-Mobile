//
//  AFJTransAnimationViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/26.
//

#import "AFJTransAnimationViewController.h"
#import "AFJCaseItemData.h"
#import "WSLAnimationTwo.h"
#import "WSLAnimationFour.h"
#import "WSLAnimationFive.h"

@interface AFJTransAnimationViewController ()
        <
        UITableViewDataSource,
        UITableViewDelegate
        >

@property(nonatomic, strong) NSArray *dataSource;

@property(nonatomic, strong) NSArray *describeArray;

@property(nonatomic, strong) NSArray *vcArray;

@end

@implementation AFJTransAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.title = @"转场动画";
    _dataSource = @[@"Push/Pop转场2", @"Push/Pop转场4", @"Push/Pop转场5"];
    _describeArray = @[@"手势过渡动画", @"开关门动画", @"全屏侧滑返回、UIScrollView、UISlider三者手势滑动事件冲突"];
    _vcArray = @[[WSLAnimationTwo class], [WSLAnimationFour class], [WSLAnimationFive class]];
}

#pragma mark -- Getter

- (UITableView *)tableView {

    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


#pragma mark -- UITableViewDelegate  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:@"piao"];
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.detailTextLabel.text = _describeArray[indexPath.row];
    cell.detailTextLabel.numberOfLines = 2;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (_vcArray[indexPath.row] == [WSLAnimationTwo class]) {
        WSLAnimationTwo *animationTwo = [[_vcArray[indexPath.row] alloc] init];
        self.currentIndexPath = indexPath;
        //在push动画之前设置动画代理
        self.navigationController.delegate = animationTwo;
        [self.navigationController pushViewController:animationTwo animated:YES];
    } else if (_vcArray[indexPath.row] == [WSLAnimationFour class]) {
        WSLAnimationFour *animationFour = [[_vcArray[indexPath.row] alloc] init];
        //在push动画之前设置动画代理
        self.navigationController.delegate = animationFour;
        [self.navigationController pushViewController:animationFour animated:YES];
    } else if (_vcArray[indexPath.row] == [WSLAnimationFive class]) {
        self.navigationController.delegate = nil;
        WSLAnimationFive *animationFive = [[_vcArray[indexPath.row] alloc] init];
        [self.navigationController pushViewController:animationFive animated:YES];
    }

}

- (void)dealloc {
    self.navigationController.delegate = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
