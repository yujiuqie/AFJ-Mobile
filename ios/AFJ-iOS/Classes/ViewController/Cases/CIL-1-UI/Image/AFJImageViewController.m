//
//  AFJImageViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/6.
//

#import "AFJImageViewController.h"
// Controller
#import "SDMasterViewController.h"
//#import "HQLImageCompressViewController.h"
//#import "HQLImageGrayCollectionViewController.h"
//#import "HQLImageCompositionViewController.h"

@interface AFJImageViewController ()



@end

@implementation AFJImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    __weak typeof(self) weakSelf = self;
    NSMutableArray *dataArray = [NSMutableArray array];
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"获取网络图片尺寸";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"获取网络图片尺寸" placeholder:[NSString stringWithFormat:@"%@/home.jpeg",AFJ_RESOURCES_PATH] complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    CGSize gifSize = [[UIImageSize new] getImageSizeWithURL:info];
                    [weakSelf showToastWithMessage:[NSString stringWithFormat:@"图片尺寸 -  %@", NSStringFromCGSize(gifSize)]];
                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"输入颜色返回一张图片";
        item.didSelectAction = ^(id data) {
            [weakSelf showInputAlert:@"输入颜色返回一张图片" placeholder:@"F0F8FF" complete:^(NSString *_Nonnull info) {
                if ([info length] > 0) {
                    UIImage *image = [UIImage createImageWithColor:[UIColor colorWithHexString:[NSString stringWithFormat:@"#%@", info]]];
                    [weakSelf showAlertWithImage:image];
                }
            }];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"显示圆形图片";
        item.didSelectAction = ^(id data) {
            UIImage *image = [UIImage circleImage:@"300-300-sample-0.jpeg"];
            [weakSelf showAlertWithImage:image];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"显示 GIF 图片";
        item.didSelectAction = ^(id data) {
            UIImage *image = [UIImage loadGifWithImageName:@"dog"];
            [weakSelf showAlertWithImage:image];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"图片水印";
        item.didSelectAction = ^(id data) {
            UIImage *image = [[UIImage imageNamed:@"300-300-sample-0.jpeg"] imageWaterMarkWithImage:[UIImage imageNamed:@"300-300-sample-11.png"] imageRect:CGRectMake(800, 800, 200, 200) alpha:0.8];
            [weakSelf showAlertWithImage:image];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"文字水印";
        item.didSelectAction = ^(id data) {

            UIFont *font = [UIFont systemFontOfSize:40];
            NSDictionary *attri = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor systemGroupedBackgroundColor]};
            UIImage *image = [[UIImage imageNamed:@"300-300-sample-0.jpeg"] imageWaterMarkWithString:@"示例文字水印效果，示例文字水印效果" rect:CGRectMake(700, 800, 300, 200) attribute:attri];
            [weakSelf showAlertWithImage:image];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"图片+文字水印";
        item.didSelectAction = ^(id data) {
            UIFont *font = [UIFont systemFontOfSize:40];
            NSDictionary *attri = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor systemGroupedBackgroundColor]};

            UIImage *image = [[UIImage imageNamed:@"300-300-sample-0.jpeg"] imageWaterMarkWithString:@"文字的相关属性，自行设置" rect:CGRectMake(500, 900, 300, 200) attribute:attri image:[UIImage imageNamed:@"300-300-sample-11.png"] imageRect:CGRectMake(800, 800, 200, 200) alpha:0.8];
            [weakSelf showAlertWithImage:image];
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"背景水印";
        item.didSelectAction = ^(id data) {
            BOOL exist = NO;
            for (UIView *view in self.view.subviews) {
                if ([view isKindOfClass:[FHXWaterMarkView class]]) {
                    [view removeFromSuperview];
                    exist = YES;
                }
            }
            if (!exist) {
                [FHXWaterMarkView waterMarkViewWithText:@"示例水印文字" withView:self.view withIsLogin:YES];
            }
        };
        [dataArray addObject:item];
    }
    {
        AFJCaseItemData *item = [AFJCaseItemData new];
        item.title = @"SDWebImage 框架";
        item.didSelectAction = ^(id data) {
            // SDWebImage 框架
            SDMasterViewController *vc = [[SDMasterViewController alloc] initWithStyle:UITableViewStylePlain];
            vc.title = @"SDWebImage 框架";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        [dataArray addObject:item];
    }
    {
//        AFJCaseItemData *item = [AFJCaseItemData new];
//        item.title = @"图片压缩";
//        item.didSelectAction = ^(id data) {
//            // 图片压缩
//            HQLImageCompressViewController *vc = [[HQLImageCompressViewController alloc] init];
//            vc.title = @"图片压缩";
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        };
//        [dataArray addObject:item];
    }
    {
//        AFJCaseItemData *item = [AFJCaseItemData new];
//        item.title = @"灰度图片";
//        item.didSelectAction = ^(id data) {
//            // 灰度图片
//            HQLImageGrayCollectionViewController *vc = [[HQLImageGrayCollectionViewController alloc] init];
//            vc.title = @"灰度图片";
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        };
//        [dataArray addObject:item];
    }
    {
//        AFJCaseItemData *item = [AFJCaseItemData new];
//        item.title = @"图片合成";
//        item.didSelectAction = ^(id data) {
//            // 图片合成
//            HQLImageCompositionViewController *vc = [[HQLImageCompositionViewController alloc] init];
//            vc.title = @"图片合成";
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//        };
//        [dataArray addObject:item];
    }

    self.dataSource = dataArray;
    [self.tableView reloadData];
}

- (void)colorCellAction:(id)data {
    AFJCaseItemData *item = data;
    NSLog(@"click %@ item", item.title);
}

@end
