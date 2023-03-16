//
//  AFJSocketViewController.h
//  AFJ-iOS
//
//  Created by viktyz on 2022/9/10.
//

#import "AFJRootViewController.h"
#import "SRWebSocket.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJSocketViewController : AFJRootListViewController
        <
        SRWebSocketDelegate,
        UITableViewDataSource,
        UITableViewDelegate,
        UITextFieldDelegate
        > {
    SRWebSocket *_webSocket;
    UITableView *_msgTabView;
}
@property(nonatomic, strong) NSMutableArray *messagesAry;
@end

@interface AFJMessage : NSObject {

}
@property(nonatomic, copy, readonly) NSString *message;
@property(nonatomic, readonly) BOOL fromMe;

- (id)initWithMessage:(NSString *)message fromMe:(BOOL)fromMe;
@end

NS_ASSUME_NONNULL_END
