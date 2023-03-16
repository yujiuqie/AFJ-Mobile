//
//  FHXAuthorizationManager.h
//  FHXAvatarPicker
//
//  Created by 冯汉栩 on 2019/4/6.
//  Copyright © 2019年 fenghanxu.compang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FHXAuthorizationManager : NSObject

+ (void)checkCameraAuthorization:(void (^)(BOOL isPermission))completion;

+ (void)requestCameraAuthorization;

+ (void)checkPhotoLibraryAuthorization:(void (^)(BOOL isPermission))completion;

+ (void)requestPhotoLibraryAuthorization;

@end

NS_ASSUME_NONNULL_END
