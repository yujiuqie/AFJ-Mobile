//
//  EMHomeViewController.h
//  MQTTChat
//
//  Created by liujinliang on 2021/4/19.
//  Copyright © 2021 Owntracks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MQTTClient/MQTTClient.h>
#import <MQTTClient/MQTTSessionManager.h>


NS_ASSUME_NONNULL_BEGIN

@interface EMHomeViewController : AFJRootViewController
        <
        MQTTSessionManagerDelegate,
        UITableViewDataSource,
        UITableViewDelegate,
        UITextFieldDelegate
        >


@end

NS_ASSUME_NONNULL_END
