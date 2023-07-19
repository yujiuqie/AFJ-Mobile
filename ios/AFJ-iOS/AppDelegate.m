//
//  AppDelegate.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/11.
//

#import "AppDelegate.h"

#import "QDUIHelper.h"
#import "QDCommonUI.h"
#import "QDTabBarViewController.h"
#import "QDNavigationController.h"
#import "QDUIKitViewController.h"
#import "QDComponentsViewController.h"
#import "QDLabViewController.h"
#import "QMUIConfigurationTemplateGrapefruit.h"
#import "QMUIConfigurationTemplateGrass.h"
#import "QMUIConfigurationTemplatePinkRose.h"
#import "QMUIConfigurationTemplateDark.h"

//#import "FLEX.h"
#import "AFJOSLogController.h"
#import "AFJMoreViewController.h"
#import "AFJNavigationController.h"
#import "MagicalRecord.h"
//#import <AlicloudAPM/AlicloudAPMProvider.h>
//#import <AlicloudHAUtil/AlicloudHAProvider.h>
#import <FinApplet/FinApplet.h>
#import "BMKCataloguePage.h"
#import <BMKLocationKit/BMKLocationComponent.h>
#import <UMCommon/UMCommon.h>
#import "QDNetServerDownLoadTool.h"
#import "AFJLogManager.h"
#import <Bugly/Bugly.h>
#import "QMUIConfigurationTemplateGrapefruit.h"
#import "QMUIConfigurationTemplateGrass.h"
#import "QMUIConfigurationTemplatePinkRose.h"
#import "QMUIConfigurationTemplateDark.h"
#import "COSTouchVisualizerWindow.h"
#import "COSTouchConfig.h"

#import "AFJNativeViewController.h"
#import "AFJFlutterViewController.h"
#import "AFJReactNativeViewController.h"
#import "AFJMoreViewController.h"

#define kBMKKey @"tP9LX058GdZsLyPjUow5GmtOkVzxys2P"

#import <Flutter/Flutter.h>
#import <FlutterPluginRegistrant-umbrella.h>

#import "QiCallTrace.h"

@interface AppDelegate ()
<
BMKGeneralDelegate,
BMKLocationAuthDelegate
>

@end

@implementation AppDelegate

#ifdef UIWindowScene_Enabled

#pragma mark - <UIWindowSceneDelegate>

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    if ([scene isKindOfClass:UIWindowScene.class]) {
        self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
        [self didInitWindow];
    }
}

#endif

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //    self.bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
    
    //    if (@available(iOS 13.0, *)) {
    
    [QiCallTrace start];
    
    self.logVC = [[AFJLogViewController alloc] init];
    [AFJOSLogController withUpdateHandler:^(NSArray<AFJSystemLogMessage *> *newMessages) {
        [[AFJLogManager sharedInstance] updateLogs:newMessages];
        //TODO::
    }];
    
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreAtURL:[NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/TMagicalRecord.sqlite"]]];
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelOff];
    
    [Bugly startWithAppId:@"95f2a26f27"];
    
    [UMConfigure initWithAppkey:@"631877e788ccdf4b7e266918" channel:@"App Store"];
    
    //测试断点续传和后台下载需要开启这个
    [QDNetServerDownLoadTool sharedTool];//先把遗留信息处理一下
    
    [self initBaidu];
    [self initFlutter];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:launchOptions forKey:@"launchOptions"];
    [userDefaults synchronize];
    
    [self initMiniApp];
    
    // 1. 先注册主题监听，在回调里将主题持久化存储，避免启动过程中主题发生变化时读取到错误的值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeDidChangeNotification:) name:QMUIThemeDidChangeNotification object:nil];
    
    // 2. 然后设置主题的生成器
    QMUIThemeManagerCenter.defaultThemeManager.themeGenerator = ^__kindof NSObject * _Nonnull(NSString * _Nonnull identifier) {
        if ([identifier isEqualToString:QDThemeIdentifierDefault]) return QMUIConfigurationTemplate.new;
        if ([identifier isEqualToString:QDThemeIdentifierGrapefruit]) return QMUIConfigurationTemplateGrapefruit.new;
        if ([identifier isEqualToString:QDThemeIdentifierGrass]) return QMUIConfigurationTemplateGrass.new;
        if ([identifier isEqualToString:QDThemeIdentifierPinkRose]) return QMUIConfigurationTemplatePinkRose.new;
        if ([identifier isEqualToString:QDThemeIdentifierDark]) return QMUIConfigurationTemplateDark.new;
        return nil;
    };
    
    // 3. 再针对 iOS 13 开启自动响应系统的 Dark Mode 切换
    // 如果不需要这个功能，则不需要这一段代码
    if (QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier) {// 做这个 if(currentThemeIdentifier) 的保护只是为了避免 QD 里的配置表没启动时，没人为 currentTheme/currentThemeIdentifier 赋值，导致后续的逻辑会 crash，业务项目里理论上不会有这种情况出现，所以可以省略这个 if，直接写下面的代码就行了
        
        QMUIThemeManagerCenter.defaultThemeManager.identifierForTrait = ^__kindof NSObject<NSCopying> * _Nonnull(UITraitCollection * _Nonnull trait) {
            // 1. 如果当前系统切换到 Dark Mode，则返回 App 在 Dark Mode 下的主题
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return QDThemeIdentifierDark;
            }
            
            // 2. 如果没有命中1，说明此时系统是 Light，则返回 App 在 Light 下的主题即可，这里不直接返回 Default，而是先做一些复杂判断，是因为 QMUI Demo 非深色模式的主题有好几个，而我们希望不管之前选择的是 Default、Grapefruit 还是 PinkRose，只要从 Dark 切换为非 Dark，都强制改为 Default。
            
            // 换句话说，如果业务项目只有 Light/Dark 两套主题，则按下方被注释掉的代码一样直接返回 Light 下的主题即可。
            //                return QDThemeIdentifierDefault;
            
            if ([QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier isEqual:QDThemeIdentifierDark]) {
                return QDThemeIdentifierDefault;
            }
            return QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier;
        };
        QMUIThemeManagerCenter.defaultThemeManager.respondsSystemStyleAutomatically = YES;
    }
    
    // QMUIConsole 默认只在 DEBUG 下会显示，作为 Demo，改为不管什么环境都允许显示
    [QMUIConsole sharedInstance].canShow = YES;
    
    // QD自定义的全局样式渲染
    [QDCommonUI renderGlobalAppearances];
    
    // 预加载 QQ 表情，避免第一次使用时卡顿
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [QDUIHelper qmuiEmotions];
    });
    
#ifndef UIWindowScene_Enabled
    // 界面
    self.window = [[UIWindow alloc] init];
    [self didInitWindow];
#endif
    
    [QiCallTrace stop];
    [QiCallTrace save];
    //    }
    
    return YES;
}

#pragma mark -

- (void)startCustomHawkeye {
    // Background is not include in `MTHawkeye` by default, you need to add it explicitly.
    //    MTHBackgroundTaskTraceAdaptor *backgroundTrace = [MTHBackgroundTaskTraceAdaptor new];
    //    MTHBackgroundTaskTraceHawkeyeUI *backgroundTraceUI = [MTHBackgroundTaskTraceHawkeyeUI new];
    //
    //    [[MTHawkeyeClient shared]
    //        setPluginsSetupHandler:^(NSMutableArray<id<MTHawkeyePlugin>> *_Nonnull plugins) {
    //            [MTHawkeyeDefaultPlugins addDefaultClientPluginsInto:plugins];
    //
    //            // add your additional plugins here.
    //            [plugins addObject:backgroundTrace];
    //        }
    //        pluginsCleanHandler:^(NSMutableArray<id<MTHawkeyePlugin>> *_Nonnull plugins) {
    //            // if you don't want to free plugins memory, remove this line.
    //            [MTHawkeyeDefaultPlugins cleanDefaultClientPluginsFrom:plugins];
    //
    //            // clean your additional plugins if need.
    //            [plugins removeObject:backgroundTrace];
    //        }];
    //
    //    [[MTHawkeyeClient shared] startServer];
    //
    //    [[MTHawkeyeUIClient shared]
    //        setPluginsSetupHandler:^(NSMutableArray<id<MTHawkeyeMainPanelPlugin>> *_Nonnull mainPanelPlugins, NSMutableArray<id<MTHawkeyeFloatingWidgetPlugin>> *_Nonnull floatingWidgetPlugins, NSMutableArray<id<MTHawkeyeSettingUIPlugin>> *_Nonnull defaultSettingUIPluginsInto) {
    //            [MTHawkeyeDefaultPlugins addDefaultUIClientMainPanelPluginsInto:mainPanelPlugins
    //                                          defaultFloatingWidgetsPluginsInto:floatingWidgetPlugins
    //                                                defaultSettingUIPluginsInto:defaultSettingUIPluginsInto];
    //
    //            // add your additional plugins here.
    //            [defaultSettingUIPluginsInto addObject:backgroundTraceUI];
    //        }
    //        pluginsCleanHandler:^(NSMutableArray<id<MTHawkeyeMainPanelPlugin>> *_Nonnull mainPanelPlugins, NSMutableArray<id<MTHawkeyeFloatingWidgetPlugin>> *_Nonnull floatingWidgetPlugins, NSMutableArray<id<MTHawkeyeSettingUIPlugin>> *_Nonnull defaultSettingUIPluginsInto) {
    //            // if you don't want to free plugins memory, remove this line.
    //            [MTHawkeyeDefaultPlugins cleanDefaultUIClientMainPanelPluginsFrom:mainPanelPlugins
    //                                            defaultFloatingWidgetsPluginsFrom:floatingWidgetPlugins
    //                                                  defaultSettingUIPluginsFrom:defaultSettingUIPluginsInto];
    //
    //            // clean your additional plugins if need.
    //            [defaultSettingUIPluginsInto addObject:backgroundTraceUI];
    //        }];
    //
    //    dispatch_async(dispatch_get_main_queue(), ^(void) {
    //        [[MTHawkeyeUIClient shared] startServer];
    //    });
}

#pragma mark - QMUI

- (void)didInitWindow {
    self.window.rootViewController = [self generateWindowRootViewController];
    [self.window makeKeyAndVisible];
    //    TODO::启动动画异常
    //    [self startLaunchingAnimation];
}

- (UIViewController *)generateWindowRootViewController {
    QDTabBarViewController *tabBarViewController = [[QDTabBarViewController alloc] init];
    
    // Native
    AFJNativeViewController *uikitViewController = [[AFJNativeViewController alloc] init];
    uikitViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *uikitNavController = [[QDNavigationController alloc] initWithRootViewController:uikitViewController];
    uikitNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"Native" image:UIImageMake(@"icon_tabbar_uikit") selectedImage:UIImageMake(@"icon_tabbar_uikit_selected") tag:0];
    AddAccessibilityHint(uikitNavController.tabBarItem, @"展示一系列对系统原生控件的拓展的能力");
    
    // Flutter
    AFJFlutterViewController *componentViewController = [[AFJFlutterViewController alloc] init];
    componentViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *componentNavController = [[QDNavigationController alloc] initWithRootViewController:componentViewController];
    componentNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"Flutter" image:UIImageMake(@"icon_tabbar_component") selectedImage:UIImageMake(@"icon_tabbar_component_selected") tag:1];
    AddAccessibilityHint(componentNavController.tabBarItem, @"展示一系列 Flutter 控件的拓展的能力");
    
    // React Native
    AFJReactNativeViewController *labViewController = [[AFJReactNativeViewController alloc] init];
    labViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *labNavController = [[QDNavigationController alloc] initWithRootViewController:labViewController];
    labNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"React" image:UIImageMake(@"icon_tabbar_lab") selectedImage:UIImageMake(@"icon_tabbar_lab_selected") tag:2];
    AddAccessibilityHint(labNavController.tabBarItem, @"展示一系列 React Native 控件的拓展的能力");
    
    // More
    AFJMoreViewController *moreViewController = [[AFJMoreViewController alloc] init];
    moreViewController.hidesBottomBarWhenPushed = NO;
    QDNavigationController *moreNavController = [[QDNavigationController alloc] initWithRootViewController:moreViewController];
    moreNavController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"More" image:UIImageMake(@"icon_tabbar_lab") selectedImage:UIImageMake(@"icon_tabbar_lab_selected") tag:2];
    AddAccessibilityHint(moreNavController.tabBarItem, @"展示其他 iOS 开发示例");
    
    // window root controller
    tabBarViewController.viewControllers = @[uikitNavController, componentNavController, labNavController,moreNavController];
    return tabBarViewController;
}

- (void)startLaunchingAnimation {
    UIWindow *window = self.window;
    UIView *launchScreenView = [[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil].firstObject;
    launchScreenView.frame = window.bounds;
    [window addSubview:launchScreenView];
    
    UIImageView *backgroundImageView = launchScreenView.subviews[0];
    backgroundImageView.clipsToBounds = YES;
    
    UIImageView *logoImageView = launchScreenView.subviews[1];
    UILabel *copyrightLabel = launchScreenView.subviews.lastObject;
    
    UIView *maskView = [[UIView alloc] initWithFrame:launchScreenView.bounds];
    maskView.backgroundColor = UIColorWhite;
    [launchScreenView insertSubview:maskView belowSubview:backgroundImageView];
    
    [launchScreenView layoutIfNeeded];
    
    
    [launchScreenView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:@"bottomAlign"]) {
            obj.active = NO;
            [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:launchScreenView attribute:NSLayoutAttributeTop multiplier:1 constant:NavigationContentTop].active = YES;
            *stop = YES;
        }
    }];
    
    [UIView animateWithDuration:.15 delay:0.9 options:QMUIViewAnimationOptionsCurveOut animations:^{
        [launchScreenView layoutIfNeeded];
        logoImageView.alpha = 0.0;
        logoImageView.transform = CGAffineTransformMakeScale(3, 3);
        copyrightLabel.alpha = 0;
    } completion:nil];
    [UIView animateWithDuration:1.2 delay:0.9 options:UIViewAnimationOptionCurveEaseOut animations:^{
        maskView.alpha = 0;
        backgroundImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [launchScreenView removeFromSuperview];
    }];
}

- (void)handleThemeDidChangeNotification:(NSNotification *)notification {
    
    QMUIThemeManager *manager = notification.object;
    if (![manager.name isEqual:QMUIThemeManagerNameDefault]) return;
    
    [[NSUserDefaults standardUserDefaults] setObject:manager.currentThemeIdentifier forKey:QDSelectedThemeIdentifier];
    
    [QDThemeManager.currentTheme applyConfigurationTemplate];
    
    if (QMUIHelper.canUpdateAppearance) {
        // 主题发生变化，在这里更新全局 UI 控件的 appearance
        [QDCommonUI renderGlobalAppearances];
        
        // 更新表情 icon 的颜色
        [QDUIHelper updateEmotionImages];
    }
}


#pragma mark - Baidu

- (void)initBaidu{
    [[BMKLocationAuth sharedInstance] setAgreePrivacy:YES];
    
    // 初始化定位SDK
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:kBMKKey authDelegate:self];
    
    // 要使用百度地图，先创建BMKMapManager
    BMKMapManager *mapMgr = [[BMKMapManager alloc] init];
    // 启动引擎并设置AK和delegate
    BOOL result = [mapMgr start:kBMKKey generalDelegate:self];
    if (!result) {
        NSLog(@"Baidu Map 启动引擎失败");
    }
}

/**
 联网结果回调
 
 @param iError 联网结果错误码信息，0代表联网成功
 */
- (void)onGetNetworkState:(int)iError {
    if (0 == iError) {
        NSLog(@"Baidu Map 联网成功");
    } else {
        NSLog(@"Baidu Map 联网失败：%d", iError);
    }
}

- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError {
    if (iError == 0) {
        NSLog(@"定位鉴权成功");
    } else {
        NSLog(@"定位鉴权失败%zd", iError);
    }
}


/**
 鉴权结果回调
 
 @param iError 鉴权结果错误码信息，0代表鉴权成功
 */
- (void)onGetPermissionState:(int)iError {
    if (0 == iError) {
        NSLog(@"Baidu Map 授权成功");
    } else {
        NSLog(@"Baidu Map 授权失败：%d", iError);
    }
}

#pragma mark - Ali

- (void)initAli{
    //    NSString *appVersion = @"1.0.0"; //配置项：App版本
    //    NSString *channel = @"develop"; //配置项：渠道标记
    //    NSString *nick = @"alfred"; //配置项：用户昵称
    //    [[AlicloudTlogProvider alloc] autoInitWithAppVersion:appVersion channel:channel nick:nick];
    //    [AlicloudHAProvider start];
    //    [TRDManagerService updateLogLevel:TLogLevelDebug]; //配置项：控制台可拉取的日志级别
    //
    //    [[AlicloudAPMProvider alloc] autoInitWithAppVersion:appVersion channel:channel nick:nick];
    //    [AlicloudHAProvider start];
    //
    //    [[AlicloudCrashProvider alloc] autoInitWithAppVersion:appVersion channel:channel nick:nick];
    //    [AlicloudHAProvider start];
}

#pragma mark - Mini App

- (void)initMiniApp{
    FATStoreConfig *storeConfig = [[FATStoreConfig alloc] init];
    storeConfig.sdkKey = @"aSm6IBYi86ldb72XuU8ic1uWWWqw94+3EOusNnGRz9E=";
    storeConfig.sdkSecret = @"3497069ed3d6117a";
    storeConfig.apiServer = @"https://api.finclip.com";
    FATConfig *config = [FATConfig configWithStoreConfigs:@[storeConfig]];
    
    [[FATClient sharedClient] initWithConfig:config error:nil];
}

#pragma mark - Flutter

- (void)initFlutter{
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
}

-(FlutterEngine *)flutterEngine
{
    if (!_flutterEngine) {
        FlutterEngine * engine = [[FlutterEngine alloc] initWithName:@"com.example.afjflutter"];
        if (engine.run) {
            _flutterEngine = engine;
        }
    }
    return _flutterEngine;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentCloudKitContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentCloudKitContainer alloc] initWithName:@"AFJ_iOS"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[FATClient sharedClient] handleOpenURL:url]) {
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    if ([[FATClient sharedClient] handleOpenURL:url]) {
        return YES;
    }
    return YES;
}

/**
 NSURLSession HQLDemo8ViewController 示例代码
 开启后台下载任务时，即使关闭了应用程序，这个下载任务依然在后台运行。
 
 当这个下载任务完成后，iOS 将会重新启动 app 来让任务知道，对这个我们不必放在心上。为了达到这个目的，我们可以在 app 的代理中调用下面的代码:
 */
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler
{
    self.backgroundURLSessionCompletionHandler = completionHandler;
}


//- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
//{
//#if DEBUG
//  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
//#else
//  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
//#endif
//}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
