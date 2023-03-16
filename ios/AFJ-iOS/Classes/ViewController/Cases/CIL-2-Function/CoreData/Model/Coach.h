//
//  Coach.h
//  TMagicalRecord
//
//  Created by 黑花白花 on 2017/3/18.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "CDPerson.h"

@class Team;
@interface Coach : CDPerson

@property (strong, nonatomic) Team *team;
@end
