//
//  BMKCustomAnnotationView.m
//  BMKCustomAnnotationDemo
//
//  Created by Baidu on 2020/5/19.
//  Copyright © 2020 Baidu. All rights reserved.
//

#import "BMKCustomAnnotationView.h"

@implementation BMKCustomAnnotationView

- (id)initWithAnnotation:(id <BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(0, 0, 45, 60);
        UIImageView *annotationImage = [[UIImageView alloc] initWithFrame:self.frame];
        annotationImage.animationImages = @[[UIImage imageNamed:@"bn_ugc_start"], [UIImage imageNamed:@"bn_ugc_end"]];
        annotationImage.animationDuration = 0.75 * 2;
        annotationImage.animationRepeatCount = 0;
        [annotationImage startAnimating];
        [self addSubview:annotationImage];
    }
    return self;
}

@end
