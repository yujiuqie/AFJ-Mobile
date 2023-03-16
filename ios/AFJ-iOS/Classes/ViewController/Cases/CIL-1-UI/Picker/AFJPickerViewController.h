//
//  AFJPickerViewController.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/11.
//

#import "AFJRootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJPickerModel : NSObject

@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) NSInteger userId;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *nickname;

@end

@interface AFJPickerViewController : AFJRootListViewController

@end

NS_ASSUME_NONNULL_END
