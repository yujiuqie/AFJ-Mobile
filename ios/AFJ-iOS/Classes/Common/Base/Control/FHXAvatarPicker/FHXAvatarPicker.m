//
//  FHXAvatarPicker.m
//  FHXAvatarPicker
//
//  Created by 冯汉栩 on 2019/4/6.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//   

#import "FHXResourceSheetView.h"
#import "FHXAuthorizationManager.h"

typedef void(^seletedImage)(UIImage *image);

@interface FHXAvatarPicker () <UIImagePickerControllerDelegate,
        UINavigationControllerDelegate,
        FHXResouceSheetViewDelegate>

@property(nonatomic, strong) UIImagePickerController *imagePicker;

@property(nonatomic, strong) FHXResourceSheetView *toolView;

@property(nonatomic, copy) seletedImage selectedImage;

@end

@implementation FHXAvatarPicker

+ (void)startSelected:(void (^)(UIImage *image))compleiton {
    [[self new] startSelected:^(UIImage *_Nonnull image) {
        compleiton(image);
    }];
}


- (void)startSelected:(void (^)(UIImage *_Nonnull))compleiton {
    [self.toolView show];
    self.selectedImage = compleiton;
}


#pragma mark - <FHXResouceSheetViewDelegate>

- (void)FHXResourceSheetView:(FHXResourceSheetView *)sheetView seletedMode:(ResourceMode)resourceMode {

    if (resourceMode == ResourceModeNone) {
        self.selectedImage ? self.selectedImage(nil) : nil;
        [self clean];
        return;
    }

    //从相册选取图片
    if (resourceMode == ResourceModeAlbum) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        __weak typeof(self) weakSelf = self;
        [FHXAuthorizationManager checkPhotoLibraryAuthorization:^(BOOL isPermission) {
            if (isPermission) {
                [weakSelf presentToImagePicker];
            } else {
                [FHXAuthorizationManager requestPhotoLibraryAuthorization];
            }
        }];
        //拍照
    } else if (resourceMode == ResourceModeCamera) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;

        __weak typeof(self) weakSelf = self;
        [FHXAuthorizationManager checkCameraAuthorization:^(BOOL isPermission) {
            if (isPermission) {
                [weakSelf presentToImagePicker];
            } else {
                [FHXAuthorizationManager requestCameraAuthorization];
            }
        }];
    }
}


- (void)presentToImagePicker {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootVC = [[[UIApplication sharedApplication] delegate] window].rootViewController;
        [rootVC presentViewController:self.imagePicker animated:YES completion:nil];
    });
}

#pragma mark - <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {

    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.selectedImage ? self.selectedImage(image) : nil;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self clean];
    }];

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.selectedImage ? self.selectedImage(nil) : nil;
    [picker dismissViewControllerAnimated:YES completion:^{
        [self clean];
    }];
}


- (void)clean {
    self.toolView.delegate = nil;
    self.toolView = nil;
}


#pragma mark - getter

- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES;
    }
    return _imagePicker;
}


- (FHXResourceSheetView *)toolView {
    if (!_toolView) {
        _toolView = [FHXResourceSheetView new];
        _toolView.delegate = self;
    }
    return _toolView;
}


- (void)dealloc {
    NSLog(@"picker dealloc");
}

@end
