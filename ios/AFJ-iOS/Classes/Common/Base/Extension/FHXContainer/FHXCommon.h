//
//  FHXCommon.h
//  FHXContainer
//
//  Created by 冯汉栩 on 2019/1/10.
//  Copyright © 2018 冯汉栩. All rights reserved.
//

#ifndef FHXCommon_h
#define FHXCommon_h

// Debug Logging
#ifdef DEBUG
#define MagicLog(x, ...) NSLog(x, ## __VA_ARGS__);
#else
#define MagicLog(x, ...)
#endif

#endif /* FHXCommon_h */
