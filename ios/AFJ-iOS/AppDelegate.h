//
//  AppDelegate.h
//  AFJ-iOS
//
//  Created by Alfred on 2022/8/11.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Flutter/Flutter.h>
#import "AFJCaseItemData.h"
#import "AFJLogViewController.h"
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

typedef NS_ENUM(NSUInteger, AJFRootVCType) {
    AJFRootVCType_Drawer = 0,
    AJFRootVCType_Tab
};

@interface AppDelegate : UIResponder
<
UIApplicationDelegate
>

@property (nonatomic, strong) FlutterEngine *flutterEngine;
@property (nonatomic, strong) UIWindow * window;
@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;

@property (nonatomic, weak) RCTBridge *bridge;
@property (nonatomic, strong) AFJLogViewController *logVC;

@property (nonatomic, strong) UINavigationController *nativeNav;
@property (nonatomic, strong) UIViewController *tmpRootVC;
@property (nonatomic, assign) BOOL allowOrentitaionRotation;

@property (nonatomic, assign) AJFRootVCType rVCType;

@property (copy) void (^backgroundURLSessionCompletionHandler)(void);

- (void)saveContext;

@end

