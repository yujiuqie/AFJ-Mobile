//
//  EMHomeViewController.m
//  MQTTChat
//
//  Created by liujinliang on 2021/4/19.
//  Copyright © 2021 Owntracks. All rights reserved.
//

#import "EMHomeViewController.h"
#import <CommonCrypto/CommonHMAC.h>
#import <AFNetworking/AFNetworking.h>
#import "Masonry.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "EMChatCell.h"


#define LF_RT_Padding  10.0f
#define Button_Width   110.0f
#define Button_Height  30.0f
#define Button_Bg_Color  [UIColor brownColor]

//环信MQTT REST API地址 通过console后台[MQTT]->[服务概览]->[服务配置]下[REST API地址]获取
#define getToken_url   @"https://a1.easemob.com/1129191118019072/test1/token"


@interface EMHomeViewController ()
/*
 * MQTTClient: keep a strong reference to your MQTTSessionManager here
 */
@property(nonatomic, strong) MQTTSessionManager *manager;
@property(nonatomic, strong) NSString *rootTopic;
//环信MQTT服务器地址 通过console后台[MQTT]->[服务概览]->[服务配置]下[连接地址]获取
@property(nonatomic, strong) NSString *host;
//协议服务端口 通过console后台[MQTT]->[服务概览]->[服务配置]下[连接端口]获取
@property(nonatomic, assign) NSInteger port;
// appID 通过console后台[MQTT]->[服务概览]->[服务配置]下[AppID]获取
@property(nonatomic, strong) NSString *appId;
@property(nonatomic, assign) NSInteger tls;
//开发者ID 通过console后台[应用概览]->[应用详情]->[开发者ID]下[ Client ID]获取
@property(nonatomic, strong) NSString *clientId;
//自定义deviceID
@property(nonatomic, strong) NSString *deviceId;

//环信MQTT REST API地址 通过console后台[MQTT]->[服务概览]->[服务配置]下[REST API地址]获取
@property(nonatomic, strong) NSString *appClientId;

//开发者ID 通过console后台[应用概览]->[应用详情]->[开发者ID]下[ Client ID]获取
@property(nonatomic, strong) NSString *restapi;

//开发者密钥 通过console后台[应用概览]->[应用详情]->[开发者ID]下[ ClientSecret]获取
@property(nonatomic, strong) NSString *appClientSecret;

@property(nonatomic, assign) NSInteger qos;

@property(nonatomic, strong) NSMutableArray *receiveMsgs;
@property(nonatomic, strong) UILabel *statusLabel;
@property(nonatomic, strong) UILabel *statusContentLabel;
@property(nonatomic, strong) UITextField *messageTextField;
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIButton *clearButton;
@property(nonatomic, strong) UIButton *disconnectButton;
@property(nonatomic, strong) UIButton *connectButton;
//发送内容按钮
@property(nonatomic, strong) UIButton *sendMsgButton;
//主题订阅按钮
@property(nonatomic, strong) UIButton *subscribeTopicButton;
//取消主题订阅按钮
@property(nonatomic, strong) UIButton *unSubscribeTopicButton;

@end


@implementation EMHomeViewController
#pragma life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MQTT Demo";

    [self placeSubviews];
    [self layoutSubViews];
    [self loadConfiguation];
}

- (void)loadConfiguation {

    self.rootTopic = @"t1";

    // appID 通过console后台[MQTT]->[服务概览]->[服务配置]下[AppID]获取
    self.appId = @"ff6sc0";

    //环信MQTT服务器地址 通过console后台[MQTT]->[服务概览]->[服务配置]下[连接地址]获取
    self.host = @"ff6sc0.cn1.mqtt.chat";

    //环信MQTT REST API地址 通过console后台[MQTT]->[服务概览]->[服务配置]下[REST API地址]获取
    self.restapi = @"https://api.cn1.mqtt.chat/app/ff6sc0";

    //开发者ID 通过console后台[应用概览]->[应用详情]->[开发者ID]下[ Client ID]获取
    self.appClientId = @"YXA67-uKaalmThCOut6Q8uPLSg";

    // 开发者密钥 通过console后台[应用概览]->[应用详情]->[开发者ID]下[ ClientSecret]获取
    self.appClientSecret = @"YXA63CFpMQFai4MdTDdGN92BBoG6_6g";

    // 协议服务端口 通过console后台[MQTT]->[服务概览]->[服务配置]下[连接端口]获取
    self.port = 1883;
    self.qos = 0;
    self.tls = 0;

    // 自定义deviceID
    self.deviceId = [UIDevice currentDevice].identifierForVendor.UUIDString;

    //开发者ID 通过console后台[应用概览]->[应用详情]->[开发者ID]下[ Client ID]获取
    self.clientId = [NSString stringWithFormat:@"%@@%@", self.deviceId, self.appId];


    /*
     * MQTTClient: create an instance of MQTTSessionManager once and connect
     * will is set to let the broker indicate to other subscribers if the connection is lost
     */
    if (!self.manager) {
        self.manager = [[MQTTSessionManager alloc] init];
        self.manager.delegate = self;

        //订阅的主题 格式为 xxx/xxx/xxx 可以为多级话题
        self.manager.subscriptions = @{[NSString stringWithFormat:@"%@/IOS", self.rootTopic]: @(self.qos), [NSString stringWithFormat:@"%@/IOS_TestToic", self.rootTopic]: @(1)};


        //【userName && passWord】需要从后台创建获取
        //自定义用户名 长度不超过64位即可
        NSString *userName = @"demo";

        [self getAppTokenWithAppClientId:self.appClientId appClientSecret:self.appClientSecret completion:^(NSString *appToken, NSInteger expires) {
            if (appToken.length > 0) {
                [self getUserTokenWithUsername:userName appToken:appToken clientId:self.clientId expires:expires completion:^(NSString *userToken) {
                    NSLog(@"=======userToken:%@==========", userToken);
                    if (userToken.length > 0) {
                        // 从console管理平台获取连接地址
                        [self.manager connectTo:self.host
                                           port:self.port
                                            tls:self.tls
                                      keepalive:45
                                          clean:true
                                           auth:true
                                           user:userName
                                           pass:userToken
                                           will:false
                                      willTopic:nil
                                        willMsg:nil
                                        willQos:MQTTQosLevelAtMostOnce
                                 willRetainFlag:false
                                   withClientId:self.clientId
                                 securityPolicy:nil
                                   certificates:nil
                                  protocolLevel:MQTTProtocolVersion50
                                 connectHandler:^(NSError *error) {
                                 }];
                    }
                }];
            }
        }];
    } else {
        [self.manager connectToLast:^(NSError *error) {

        }];
    }

    /*
     * MQTTCLient: observe the MQTTSessionManager's state to display the connection status
     */

    [self.manager addObserver:self
                   forKeyPath:@"state"
                      options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                      context:nil];
}


- (void)placeSubviews {
    [self.view addSubview:self.clearButton];
    [self.view addSubview:self.connectButton];
    [self.view addSubview:self.disconnectButton];
    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.statusContentLabel];
    [self.view addSubview:self.messageTextField];
    [self.view addSubview:self.sendMsgButton];
    [self.view addSubview:self.subscribeTopicButton];
    [self.view addSubview:self.unSubscribeTopicButton];
    [self.view addSubview:self.tableView];
}

- (void)layoutSubViews {
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60.0);
        make.left.equalTo(self.view).offset(LF_RT_Padding);
        make.right.equalTo(self.view).offset(-LF_RT_Padding);
        make.height.mas_equalTo(30.0f);
    }];

    [self.statusContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusLabel.mas_bottom).offset(10.0);
        make.left.equalTo(self.view).offset(LF_RT_Padding);
        make.right.equalTo(self.view).offset(-LF_RT_Padding);
        make.height.mas_equalTo(30.0f);
    }];

    [self.messageTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusContentLabel.mas_bottom).offset(10.0f);
        make.left.equalTo(self.view).offset(LF_RT_Padding);
        make.right.equalTo(self.view).offset(-LF_RT_Padding);
        make.height.mas_equalTo(30.0);
    }];

    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageTextField.mas_bottom).offset(10.0);
        make.left.equalTo(self.view).offset(LF_RT_Padding);
        make.height.mas_equalTo(Button_Height);
    }];


    [self.disconnectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clearButton);
        make.left.equalTo(self.clearButton.mas_right).offset(LF_RT_Padding);
        make.right.equalTo(self.connectButton.mas_left).offset(-LF_RT_Padding);
        make.size.mas_equalTo(self.clearButton);

    }];

    [self.connectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clearButton);
        make.right.equalTo(self.view).offset(-LF_RT_Padding);
        make.size.mas_equalTo(self.clearButton);
    }];


    [self.subscribeTopicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.clearButton.mas_bottom).offset(10.0f);
        make.left.equalTo(self.view).offset(LF_RT_Padding);
        make.size.equalTo(self.clearButton);
    }];


    [self.unSubscribeTopicButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subscribeTopicButton);
        make.left.equalTo(self.subscribeTopicButton.mas_right).offset(LF_RT_Padding);
        make.size.mas_equalTo(self.clearButton);
    }];

    [self.sendMsgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subscribeTopicButton);
        make.left.equalTo(self.unSubscribeTopicButton.mas_right).offset(LF_RT_Padding);
        make.size.mas_equalTo(self.clearButton);
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sendMsgButton.mas_bottom).offset(10.0f);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20.0);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark private method

//获取应用token
- (void)getAppTokenWithAppClientId:(NSString *)appClientId
                   appClientSecret:(NSString *)appClientSecret
                        completion:(void (^)(NSString *appToken, NSInteger expires))response {

    //环信MQTT REST API地址 通过console后台[MQTT]->[服务概览]->[服务配置]下[REST API地址]获取
    NSString *urlString = [NSString stringWithFormat:@"%@/openapi/rm/app/token", self.restapi];

    //初始化一个AFHTTPSessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求体，参数（NSDictionary 类型）

    NSDictionary *parameters = @{@"appClientId": appClientId,
            @"appClientSecret": appClientSecret
    };
    NSLog(@"%s\n urlString:%@\n parameters:%@\n", __func__, urlString, parameters);

    __block NSString *token = @"";
    [manager POST:urlString
       parameters:parameters
          headers:@{}
         progress:nil
          success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
              NSError *error = nil;
              NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
              NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
              NSLog(@"%s jsonDic:%@", __func__, jsonDic);
              NSDictionary *body = jsonDic[@"body"];
              token = body[@"access_token"];
              NSInteger expire_in = [body[@"expires_in"] integerValue];
              response(token, expire_in);
          }
          failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
              NSLog(@"%s error:%@", __func__, error.debugDescription);
              response(token, 0);
          }];
}


//获取用户token
- (void)getUserTokenWithUsername:(NSString *)username
                        appToken:(NSString *)appToken
                        clientId:(NSString *)clientId
                         expires:(NSInteger)expires
                      completion:(void (^)(NSString *userToken))response {

    //环信MQTT REST API地址 通过console后台[MQTT]->[服务概览]->[服务配置]下[REST API地址]获取
    NSString *urlString = [NSString stringWithFormat:@"%@/openapi/rm/user/token", self.restapi];

    //初始化一个AFHTTPSessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求体，参数（NSDictionary 类型）


    NSDictionary *parameters = @{
            @"username": username,
            @"expires_in": @(expires),//过期时间，单位为秒，默认为3天，如需调整，可提工单调整
            @"cid": clientId
    };
    NSLog(@"%s\n urlString:%@\n parameters:%@\n", __func__, urlString, parameters);

    __block NSString *token = @"";

    [manager POST:urlString
       parameters:parameters
          headers:@{@"Authorization": appToken}
         progress:nil
          success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
              NSError *error = nil;
              NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
              NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
              NSLog(@"%s jsonDic:%@", __func__, jsonDic);
              NSDictionary *body = jsonDic[@"body"];
              token = body[@"access_token"];

              response(token);
          }
          failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
              NSLog(@"%s error:%@", __func__, error.debugDescription);
              response(token);
          }];
}


+ (NSString *)macSignWithText:(NSString *)text secretKey:(NSString *)secretKey {
    NSData *saltData = [secretKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData *paramData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *hash = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, saltData.bytes, saltData.length, paramData.bytes, paramData.length, hash.mutableBytes);
    NSString *base64Hash = [hash base64EncodedStringWithOptions:0];

    return base64Hash;
}


#pragma mark event response

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;

}

- (void)clear {
    [self.receiveMsgs removeAllObjects];
    [self.tableView reloadData];
}

/*
 * 重新连接
 */
- (void)connect {
    [self.manager connectToLast:^(NSError *error) {

    }];
}

/*
 * 断开连接
 */
- (void)disConnect {
    [self.manager disconnectWithDisconnectHandler:^(NSError *error) {

    }];

    self.manager.subscriptions = @{};
}

- (void)send {
    /*
     * MQTTClient: send data to broker
     */

    [self.manager sendData:[self.messageTextField.text dataUsingEncoding:NSUTF8StringEncoding]
                     topic:[NSString stringWithFormat:@"%@/%@",
                                                      self.rootTopic,
                                                      @"IOS"]//此处设置多级子topic
                       qos:self.qos
                    retain:FALSE];
}


/**
  订阅主题
  格式为 xxx/xxx/xxx 可以为多级话题 @{@"xxx/xxx/xxx...":@(1)}
  qos定义{ 0: 最多一次，1:至少一次 2:仅一次}
*/
- (void)subScribeTopic {
    self.manager.subscriptions = @{[NSString stringWithFormat:@"%@/IOS", self.rootTopic]: @(self.qos), [NSString stringWithFormat:@"%@/IOS_TestToic", self.rootTopic]: @(1)};


}

/**
  取消订阅主题
*/
- (void)unSubScribeTopic {
    self.manager.subscriptions = @{};

//    NSString *unSubTopic = self.messageTextField.text;
//    NSMutableDictionary *currentSubscriptions = [NSMutableDictionary dictionaryWithDictionary:self.manager.effectiveSubscriptions];
//
//    if ([currentSubscriptions objectForKey:unSubTopic] != nil) {
//        [currentSubscriptions removeObjectForKey:unSubTopic];
//    }
//
//    self.manager.subscriptions = currentSubscriptions;

}


#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    switch (self.manager.state) {
        case MQTTSessionManagerStateClosed:
            self.statusContentLabel.text = @"closed";
            self.disconnectButton.enabled = false;
            self.connectButton.enabled = true;
            break;
        case MQTTSessionManagerStateClosing:
            self.statusContentLabel.text = @"closing";
            self.disconnectButton.enabled = false;
            self.connectButton.enabled = false;
            break;
        case MQTTSessionManagerStateConnected:
            self.statusContentLabel.text = [NSString stringWithFormat:@"connected as %@", self.clientId];
            self.disconnectButton.enabled = true;
            self.connectButton.enabled = false;
            break;
        case MQTTSessionManagerStateConnecting:
            self.statusContentLabel.text = @"connecting";
            self.disconnectButton.enabled = false;
            self.connectButton.enabled = false;
            break;
        case MQTTSessionManagerStateError:
            self.statusContentLabel.text = @"error";
            self.disconnectButton.enabled = false;
            self.connectButton.enabled = false;
            break;
        case MQTTSessionManagerStateStarting:
            break;
        default:
            self.statusContentLabel.text = @"not connected";
            self.disconnectButton.enabled = false;
            self.connectButton.enabled = true;
            [self.manager connectToLast:^(NSError *error) {

            }];
            break;
    }
}


#pragma mark MQTTSessionManagerDelegate

/*
 * MQTTSessionManagerDelegate
 */
- (void)handleMessage:(NSData *)data onTopic:(NSString *)topic retained:(BOOL)retained {
    /*
     * MQTTClient: process received message
     */

    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    [self.receiveMsgs insertObject:[NSString stringWithFormat:@"RecvMsg from Topic: %@ Body: %@", topic, dataString] atIndex:0];
    [self.tableView reloadData];
}

- (void)messageDelivered:(UInt16)msgID {
    NSLog(@"%s msgId:%@", __func__, @(msgID));

}


#pragma mark UITableViewDelegate && UITableViewDataSource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EMChatCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[EMChatCell indentifier]];
    cell.messageLabel.text = self.receiveMsgs[indexPath.row];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.receiveMsgs.count;
}


#pragma mark getter and setter

- (UILabel *)statusLabel {
    if (_statusLabel == nil) {
        _statusLabel = UILabel.new;
        _statusLabel.textColor = UIColor.blackColor;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.font = [UIFont systemFontOfSize:20.0];
        _statusLabel.text = @"连接状态";
    }
    return _statusLabel;
}


- (UILabel *)statusContentLabel {
    if (_statusContentLabel == nil) {
        _statusContentLabel = UILabel.new;
        _statusContentLabel.textColor = UIColor.blackColor;
        _statusContentLabel.textAlignment = NSTextAlignmentLeft;
        _statusContentLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _statusContentLabel;
}


- (UIButton *)clearButton {
    if (_clearButton == nil) {
        _clearButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_clearButton setTitle:@"clear" forState:UIControlStateNormal];
        [_clearButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _clearButton.backgroundColor = Button_Bg_Color;
        _clearButton.layer.cornerRadius = 5.0;
        [_clearButton addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

- (UIButton *)connectButton {
    if (_connectButton == nil) {
        _connectButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_connectButton setTitle:@"connect" forState:UIControlStateNormal];
        [_connectButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _connectButton.backgroundColor = Button_Bg_Color;
        _connectButton.layer.cornerRadius = 5.0;

        [_connectButton addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectButton;
}

- (UIButton *)disconnectButton {
    if (_disconnectButton == nil) {
        _disconnectButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_disconnectButton setTitle:@"disConnect" forState:UIControlStateNormal];
        [_disconnectButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _disconnectButton.backgroundColor = Button_Bg_Color;
        _disconnectButton.layer.cornerRadius = 5.0;

        [_disconnectButton addTarget:self action:@selector(disConnect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _disconnectButton;
}

- (UITextField *)messageTextField {
    if (_messageTextField == nil) {
        _messageTextField = UITextField.new;
        _messageTextField.backgroundColor = UIColor.lightGrayColor;
        _messageTextField.layer.cornerRadius = 5.0;
        _messageTextField.delegate = self;
        _messageTextField.placeholder = @"输入发送的消息";
    }
    return _messageTextField;
}


- (UIButton *)sendMsgButton {
    if (_sendMsgButton == nil) {
        _sendMsgButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_sendMsgButton setTitle:@"send" forState:UIControlStateNormal];
        [_sendMsgButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _sendMsgButton.backgroundColor = Button_Bg_Color;
        _sendMsgButton.layer.cornerRadius = 5.0;
        [_sendMsgButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendMsgButton;
}

- (UIButton *)subscribeTopicButton {
    if (_subscribeTopicButton == nil) {
        _subscribeTopicButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_subscribeTopicButton setTitle:@"subScribe" forState:UIControlStateNormal];
        [_subscribeTopicButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _subscribeTopicButton.backgroundColor = Button_Bg_Color;
        _subscribeTopicButton.layer.cornerRadius = 5.0;
        [_subscribeTopicButton addTarget:self action:@selector(subScribeTopic) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subscribeTopicButton;
}

- (UIButton *)unSubscribeTopicButton {
    if (_unSubscribeTopicButton == nil) {
        _unSubscribeTopicButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_unSubscribeTopicButton setTitle:@"unSubScribe" forState:UIControlStateNormal];
        [_unSubscribeTopicButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _unSubscribeTopicButton.backgroundColor = Button_Bg_Color;
        _unSubscribeTopicButton.layer.cornerRadius = 5.0;
        [_unSubscribeTopicButton addTarget:self action:@selector(unSubScribeTopic) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unSubscribeTopicButton;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 30.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;

        [_tableView registerClass:[EMChatCell class] forCellReuseIdentifier:[EMChatCell indentifier]];
    }
    return _tableView;
}

- (NSMutableArray *)receiveMsgs {
    if (_receiveMsgs == nil) {
        _receiveMsgs = NSMutableArray.new;
    }
    return _receiveMsgs;
}


@end

#undef LF_RT_Padding
#undef Button_Width
#undef Button_Height
#undef Button_Bg_Color
#undef getToken_url
