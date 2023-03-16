//
//  LoadPodImage.m
//  NerdyUI
//
//  Created by 冯汉栩 on 2020/3/17.
//

@implementation LoadPodImage

+ (UIImage *)imageWithName:(NSString *)name ofType:(NSString *)type {

    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"Asserts" ofType:@"bundle"];

    NSBundle *bundle_2 = [NSBundle bundleWithPath:path];

    return [[UIImage imageWithContentsOfFile:[bundle_2 pathForResource:name ofType:type]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
