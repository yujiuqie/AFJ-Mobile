//
//  FHXAnnotation.h
//  FHXContainer
//
//  Created by 冯汉栩 on 2019/1/15.
//  Copyright © 2019 冯汉栩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHXContainerDefines.h"

#ifndef ContainerModSectName
#define ContainerModSectName  "ContainerMods"
#endif

#define ContainerDATA(sectname) __attribute((used, section("__DATA,"#sectname" ")))


/**
 模块注册宏（同步触发模块的init事件）
 @param name 模块名称
 */
#define ContainerMod(name) \
class FHXContainerDefines; char * k##name##_mod ContainerDATA(ContainerMods) = ""#name"";

@interface FHXAnnotation : NSObject

@end
