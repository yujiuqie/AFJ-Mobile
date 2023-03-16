//
//  AFJDSBridgeViewController.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/22.
//

#import "AFJRootViewController.h"
#import "dsbridge.h"
#import "JsApiTest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFJDSBridgeViewController : AFJRootListViewController
        <
        WKNavigationDelegate
        > {
    JsApiTest *jsApi;
}

@end

NS_ASSUME_NONNULL_END
