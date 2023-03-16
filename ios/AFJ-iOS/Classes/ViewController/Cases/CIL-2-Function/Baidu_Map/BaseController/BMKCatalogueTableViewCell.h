//
//  BMKCatalogueTableViewCell.h
//  BMKObjectiveCDemo
//
//  Created by Baidu RD on 2018/3/5.
//  Copyright © 2018年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMKCatalogueTableViewCell : UITableViewCell
- (void)refreshUIWithData:(NSArray *)titles images:(NSArray *)images atIndexPath:(NSUInteger)indexpath;
@end
