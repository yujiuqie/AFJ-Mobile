//
//  BMKSecondaryCataloguePage.h
//  BMKObjectiveCDemo
//
//  Created by Baidu RD on 2018/3/6.
//  Copyright © 2018年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKCatalogueTableViewCell.h"

@interface BMKSecondaryCataloguePage : UIViewController
@property(nonatomic, copy) NSArray *catalogueDatas;
@property(nonatomic, copy) NSString *currentTitle;
@end
