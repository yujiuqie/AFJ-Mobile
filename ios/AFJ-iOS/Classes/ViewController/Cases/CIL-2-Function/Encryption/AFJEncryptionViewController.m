//
//  AFJEncryptionViewController.m
//  AFJ-iOS
//
//  Created by viktyz on 2022/8/15.
//

#import "AFJEncryptionViewController.h"
#import "SYBaseViewController.h"

@interface AFJEncryptionViewController ()
        <
        UITableViewDelegate,
        UITableViewDataSource
        >

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *datas;

@property(nonatomic, strong) SYBaseViewController *baseVC;

@end

@implementation AFJEncryptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"各种类型加密";

    [self.view addSubview:self.tableView];
    self.datas = @[@"DES", @"AES", @"RSA", @"MD5"];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@加密", self.datas[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *str = [NSString stringWithFormat:@"SY%@ViewController", self.datas[indexPath.row]];
    UIViewController *vc = [[NSClassFromString(str) alloc] initWithNibName:@"SYBaseViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
