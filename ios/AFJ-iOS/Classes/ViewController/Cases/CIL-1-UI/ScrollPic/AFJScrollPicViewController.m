//
//  AFJScrollPicViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/26.
//

#import "AFJScrollPicViewController.h"
#import "DCPicScrollView.h"

@interface AFJScrollPicViewController ()

@end

@implementation AFJScrollPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSMutableArray *arr2 = [[NSMutableArray alloc] init];

    NSMutableArray *arr3 = [[NSMutableArray alloc] init];

    for (int i = 1; i < 8; i++) {
        [arr2 addObject:[NSString stringWithFormat:@"%d.jpg", i]];
        [arr3 addObject:[NSString stringWithFormat:@"我是第%d张图片啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊", i]];
    };


    DCPicScrollView *picView1 = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 270) WithImageUrls:arr2];

    picView1.titleData = arr3;

    picView1.backgroundColor = [UIColor clearColor];
    [picView1 setImageViewDidTapAtIndex:^(NSInteger index) {
        printf("你点到我了😳index:%zd\n", index);
    }];

    picView1.AutoScrollDelay = 2.0f;

    [self.view addSubview:picView1];
}


@end
