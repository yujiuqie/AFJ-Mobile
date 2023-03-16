//
//  AFJCaseItemData.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/11.
//

NS_ASSUME_NONNULL_BEGIN

@interface AFJCaseItemData : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic, copy) NSString *link;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *flag;
@property(nonatomic, copy) NSArray *list;
@property(nonatomic, copy) NSDictionary *cookie;
@property(nonatomic, copy) NSString *entrance;
//@property(nonatomic, copy) NSString *hasDemo; //change to flag
//@property(nonatomic, copy) NSString *link; //change to link
@property(nonatomic, copy) void (^didSelectAction)(id data);

@end


NS_ASSUME_NONNULL_END
