//
//  AFJScanCodeViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/16.
//

#import "AFJScanCodeViewController.h"

@interface AFJScanCodeViewController ()
        <
        UIImagePickerControllerDelegate,
        UINavigationControllerDelegate
        >


@property(nonatomic, strong) NSArray<NSArray *> *arrayItems;

@end

@implementation AFJScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
