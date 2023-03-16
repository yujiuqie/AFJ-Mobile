//
//  AFJImageSampleViewController.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/20.
//

#import "AFJRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJImageSampleViewController : AFJRootListViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarDelegate, UIActionSheetDelegate, UIScrollViewDelegate>
{
    IBOutlet __weak UIScrollView *_scrollView;
    IBOutlet __weak UIImageView *_imageView;
}

@end

NS_ASSUME_NONNULL_END
