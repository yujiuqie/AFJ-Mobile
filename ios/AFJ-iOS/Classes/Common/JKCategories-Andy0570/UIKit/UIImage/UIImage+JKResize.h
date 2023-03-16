// UIImage+Resize.h
// Created by Trevor Harmon on 8/5/09.
//

/// Extends the UIImage class to support resizing/cropping
#import <UIKit/UIKit.h>

@interface UIImage (JKResize)

- (UIImage *)jk_croppedImage:(CGRect)bounds;
- (UIImage *)jk_thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)jk_resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)jk_resizedImage:(CGSize)newSize;
- (UIImage *)jk_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
@end
