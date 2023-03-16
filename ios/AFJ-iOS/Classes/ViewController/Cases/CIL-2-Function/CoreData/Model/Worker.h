//
//  Worker.h
//  TMagicalRecord
//
//  Created by 黑花白花 on 2017/3/18.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "CDPerson.h"

@class Snack;
@class Ticket;
@interface Worker : CDPerson

@property (strong, nonatomic) Ticket *ticket;
@property (strong, nonatomic) NSArray *projects;
@property (strong, nonatomic) NSArray<Snack *> *snacks;

@end
