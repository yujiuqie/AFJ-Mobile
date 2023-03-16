//
//  AFJSocketViewController.m
//  AFJ-iOS
//
//  Created by viktyz on 2022/9/10.
//

#import "AFJSocketViewController.h"

@interface AFJSocketViewController ()

@end

@implementation AFJSocketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0f)
//    {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    self.view.backgroundColor = [UIColor whiteColor];
    _messagesAry = [NSMutableArray array];
    self.navigationItem.title = @"打开连接...";
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"Server" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarBtnClick:)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;

    UITextField *tfServer = [[UITextField alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, self.view.frame.size.width, 30.0f)];
    tfServer.tag = 1;
    tfServer.backgroundColor = [UIColor yellowColor];
    tfServer.placeholder = @"ws://82.157.123.54:9010/ajaxchattest";
    tfServer.delegate = self;
    tfServer.returnKeyType = UIReturnKeyDone;
    tfServer.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:tfServer];

    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30.0f)];
    tf.tag = 2;
    tf.backgroundColor = [UIColor greenColor];
    tf.delegate = self;
    tf.returnKeyType = UIReturnKeyDone;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;

    _msgTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight + 30.0, SCREENW, SCREENH - 30.0)];
    _msgTabView.backgroundColor = [UIColor whiteColor];
    _msgTabView.dataSource = self;
    _msgTabView.delegate = self;
    _msgTabView.tableHeaderView = tf;
    _msgTabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _msgTabView.separatorColor = [UIColor grayColor];
    [self.view addSubview:_msgTabView];

    [self reconnect:@"ws://82.157.123.54:9010/ajaxchattest"];
}

- (void)reconnect:(NSString *)wsSocketURL {
    _webSocket.delegate = nil;
    [_webSocket close];

    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:wsSocketURL]]];
    _webSocket.delegate = self;
    [_webSocket open];
}

- (void)rightBarBtnClick:(UIBarButtonItem *)item {
    [self showInputAlert:@"输入 Server 服务器地址" placeholder:@"http://coolaf.com/tool/chattest" complete:^(NSString *_Nonnull info) {
        [self presentWebViewWith:info];
    }];
}

#pragma mark  SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"Received \"%@\"", message);
    [_messagesAry addObject:[[AFJMessage alloc] initWithMessage:message fromMe:NO]];
    [_msgTabView reloadData];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Websocket Connected");
    self.navigationItem.title = @"已连接!";
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"Websocket Failed With Error %@", error);
    self.navigationItem.title = @"Connection Failed! (see logs)";
    _webSocket = nil;

}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"WebSocket closed");
    self.navigationItem.title = @"连接已关闭!";
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    NSLog(@"Websocket received pong %@", [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding]);
}


#pragma mark UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messagesAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }

    AFJMessage *msg = [_messagesAry objectAtIndex:indexPath.row];
    cell.backgroundColor = msg.fromMe ? [UIColor colorWithRed:247.0f / 255.0f green:198.0f / 255.0f blue:69.0f / 255.0f alpha:1.0f] : [UIColor colorWithRed:197.0f / 255.0f green:255.0f / 255.0f blue:58.0f / 255.0f alpha:1.0f];
    cell.textLabel.text = [[_messagesAry objectAtIndex:indexPath.row] message];


    return cell;

}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1) {
        [textField resignFirstResponder];
        if ([textField.text length] > 0) {
            [self reconnect:textField.text];
        } else {
            [self reconnect:textField.placeholder];
        }
    } else if (textField.tag == 2) {
        [textField resignFirstResponder];
        NSError *error = nil;
        [_webSocket sendString:textField.text error:&error];
        [_messagesAry addObject:[[AFJMessage alloc] initWithMessage:textField.text fromMe:YES]];
        if (error) {
            [_messagesAry addObject:[[AFJMessage alloc] initWithMessage:[error description] fromMe:YES]];
        }
        [_msgTabView reloadData];
        textField.text = @"";
    }

    return YES;
}

- (void)dealloc {
    [_webSocket close];
    _webSocket = nil;
    _messagesAry = nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

@implementation AFJMessage

- (id)initWithMessage:(NSString *)message fromMe:(BOOL)fromMe; {
    self = [super init];
    if (self) {
        _fromMe = fromMe;
        _message = message;
    }

    return self;
}

@end
