//
//  Foundation+Log.h
//  淘宝宝
//
//  Created by XFS on 2020/4/21.
//  Copyright © 2020 陈波. All rights reserved.
//

#ifndef Foundation_Log_h
#define Foundation_Log_h


//解决控制台中文打印问题


@interface NSDictionary (Log)
- (NSString *)descriptionWithLocale:(id)locale;

@end

@interface NSArray (Log)
- (NSString *)descriptionWithLocale:(id)locale;

@end


#endif /* Foundation_Log_h */
