//
//  FHXAnnotation.m
//  FHXContainer
//
//  Created by 冯汉栩 on 2019/1/15.
//  Copyright © 2019 冯汉栩. All rights reserved.
//

#include <mach-o/getsect.h>
#include <mach-o/dyld.h>
#include <mach-o/ldsyms.h>

NSArray<NSString *> *FHXReadConfiguration(char *sectionName, const struct mach_header *mhp);

static void dyld_callback(const struct mach_header *mhp, intptr_t vmaddr_slide) {
    NSArray *mods = FHXReadConfiguration(ContainerModSectName, mhp);
    for (NSString *modName in mods) {
        Class cls;
        if (modName) {
            cls = NSClassFromString(modName);

            if (cls) {
                [[FHXModuleManager shareInstance] registerModule:cls];
            }
        }
    }
}

__attribute__((constructor))
void initProphet() {
    _dyld_register_func_for_add_image(dyld_callback);
}

NSArray<NSString *> *FHXReadConfiguration(char *sectionName, const struct mach_header *mhp) {
    NSMutableArray *configs = [NSMutableArray array];
    unsigned long size = 0;
#ifndef __LP64__
    uintptr_t *memory = (uintptr_t*)getsectiondata(mhp, SEG_DATA, sectionName, &size);
#else
    const struct mach_header_64 *mhp64 = (const struct mach_header_64 *) mhp;
    uintptr_t *memory = (uintptr_t *) getsectiondata(mhp64, SEG_DATA, sectionName, &size);
#endif

    unsigned long counter = size / sizeof(void *);
    for (int idx = 0; idx < counter; ++idx) {
        char *string = (char *) memory[idx];
        NSString *str = [NSString stringWithUTF8String:string];
        if (!str)continue;

        if (str) [configs addObject:str];
    }

    return configs;
}


@implementation FHXAnnotation

@end
