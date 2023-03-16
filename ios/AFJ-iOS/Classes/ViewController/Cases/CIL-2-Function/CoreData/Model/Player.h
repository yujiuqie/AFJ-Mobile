//
//  Player.h
//  TMagicalRecord
//
//  Created by 黑花白花 on 2017/3/18.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "CDPerson.h"

@class Team;
@interface Player : CDPerson

@property (copy, nonatomic) NSString *role;
@property (assign, nonatomic) NSString *number;

@property (strong, nonatomic) Team *team;


@end
