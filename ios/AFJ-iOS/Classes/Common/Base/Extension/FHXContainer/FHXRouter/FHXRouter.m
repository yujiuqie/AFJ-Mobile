//
//  FHXRouter.m
//  FHXRouterDemo
//
//  Created by 冯汉栩 on 2018/6/18.
//  Copyright © 2018年 冯汉栩. All rights reserved.
//

#pragma mark - >>> Global Area
static NSString *const FHXURLFragmentViewControlerEnterModePush = @"push";
static NSString *const FHXURLFragmentViewControlerEnterModeModal = @"modal";

static NSString *const FHXURLFragmentViewControlerEnterModePop = @"pop";
static NSString *const FHXURLFragmentViewControlerEnterModeDismiss = @"dismiss";

typedef NS_ENUM(NSUInteger, FHXRouterViewControlerEnterMode) {
    FHXRouterViewControlerEnterModeUnknown,   //未知类型(不进行跳转，只获取return object)
    FHXRouterViewControlerEnterModePush,      //push操作
    FHXRouterViewControlerEnterModeModal,     //modal操作
    FHXRouterViewControlerEnterModePop,       //pop操作      收回控制器
    FHXRouterViewControlerEnterModeDismiss    //dismiss操作  收回控制器
};

void router_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    BOOL didAddMethod = class_addMethod(class,
            originalSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - >>> UINavigationController(FHXRouter)

@interface UINavigationController (FHXRouter)

@end

@implementation UINavigationController (FHXRouter)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        router_swizzleMethod(class, @selector(viewWillAppear:), @selector(aop_NavigationViewWillAppear:));
    });
}

- (void)aop_NavigationViewWillAppear:(BOOL)animation {
    [self aop_NavigationViewWillAppear:animation];
    /**
        这里要判断一下赋值之前是否是导航栏，因为跳去选择图片的时候，会进来赋值一个值并没有导航栏的。出去之后用路由跳转导航栏为nil。注册选择图片会出现这个BUG
        我的项目用自定义导航栏的      FHXNavigationController
     */
    if ([self isKindOfClass:[FHXNavigationController class]]) {
        [FHXRouter sharedInstance].currentNavigationController = self;
    }
}

@end

#pragma mark - >>> FHXRouter

@interface FHXRouter ()

@end

@implementation FHXRouter

#pragma mark - 全局访问点

+ (instancetype)sharedInstance {
    static FHXRouter *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[FHXRouter alloc] init];
    });

    return router;
}

#pragma mark - Public Method - OpenURL

+ (BOOL)canOpenURL:(NSURL *)URL {
    if (!URL) {
        return NO;
    }

    NSString *scheme = URL.scheme;
    if (!scheme.length) {
        return NO;
    }

    NSString *host = URL.host;
    if (!host.length) {
        return NO;
    }

    __block BOOL flag = YES;

    //优先查找Class
    NSString *reflectStr = [NSString stringWithFormat:@"Service_%@", host];

    Class mClass = NSClassFromString(reflectStr);

    //selector
    NSArray<NSString *> *pathComponents = URL.pathComponents;

    __block NSString *selectorStr;

    [pathComponents enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (![obj isEqualToString:@"/"]) {
            selectorStr = obj;
        }
    }];

    if (mClass) {
        if (selectorStr) {
            selectorStr = [NSString stringWithFormat:@"func_%@:", selectorStr];

            SEL selector = NSSelectorFromString(selectorStr);

            id instance = [[mClass alloc] init];

            if (![instance respondsToSelector:selector]) {
                flag = NO;
            } else {
                flag = YES;
            }
        } else {
            flag = NO;
        }
    }

    return flag;
}

+ (BOOL)openURL:(NSURL *)URL {
    return [self openURL:URL withParams:nil customHandler:nil];
}

+ (BOOL)openURL:(NSURL *)URL withParams:(NSDictionary<NSString *, NSString *> *)params {
    return [self openURL:URL withParams:params customHandler:nil];
}

+ (BOOL)openURL:(NSURL *)URL
     withParams:(NSDictionary<NSString *, NSString *> *)params
  customHandler:(void (^)(NSString *pathComponentKey, id returnValue))customHandler {

    if (![self canOpenURL:URL]) {
        NSString *errMsg = [NSString stringWithFormat:@"FHXRouterError:[%@]未能正常打开,请检查target服务类在项目中是否存在并可以正常响应action事件.", URL.absoluteString];
        NSLog(@"errMsg = %@", errMsg);
        return NO;
    }

    NSString *host = URL.host;

    FHXRouterViewControlerEnterMode enterMode = FHXRouterViewControlerEnterModeUnknown;
    if (URL.fragment.length) {
        enterMode = [self viewControllerEnterMode:URL.fragment];
    }

    //parameters
    NSDictionary<NSString *, NSString *> *queryDic = [self queryParameterFromURL:URL];

    //selectorStr
    __block NSString *selectorStr;

    NSArray<NSString *> *pathComponents = URL.pathComponents;

    [pathComponents enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (![obj isEqualToString:@"/"]) {
            selectorStr = obj;
        }
    }];

    //通过Target-Action调用
    NSString *reflectStr = [NSString stringWithFormat:@"Service_%@", host];
    Class mClass = NSClassFromString(reflectStr);;
    selectorStr = [NSString stringWithFormat:@"func_%@:", selectorStr];
    SEL selector = NSSelectorFromString(selectorStr);
    id instance = [[mClass alloc] init];

    NSDictionary<NSString *, id> *finalParams = [self solveURLParams:queryDic withFuncParams:params forClass:mClass];

    id returnValue = [self safePerformAction:selector target:instance params:finalParams];

    NSString *pathComponentKey = [NSString stringWithFormat:@"%@.%@", reflectStr, selectorStr];

    if (enterMode == FHXRouterViewControlerEnterModePush || enterMode == FHXRouterViewControlerEnterModeModal || enterMode == FHXRouterViewControlerEnterModePop || enterMode == FHXRouterViewControlerEnterModeDismiss) {
        [self solveJumpWithViewController:(UIViewController *) returnValue andJumpMode:enterMode shouldAnimate:YES];
    }

    !customHandler ?: customHandler(pathComponentKey, returnValue);

    return YES;
}

#pragma mark - Public Method - Target-Action

+ (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params {

    NSString *targetClassString = [NSString stringWithFormat:@"Service_%@", targetName];
    NSString *actionString = [NSString stringWithFormat:@"func_%@:", actionName];
    Class targetClass = NSClassFromString(targetClassString);
    NSObject *target = [[targetClass alloc] init];

    SEL action = NSSelectorFromString(actionString);

    if (target == nil) {
        [self NoTargetActionResponseWithTargetString:targetClassString selectorString:actionString];
        return nil;
    }

    if ([target respondsToSelector:action]) {
        return [self safePerformAction:action target:target params:params];
    } else {
        NSString *errMsg = [NSString stringWithFormat:@"FHXRouterError:%@未能正常响应%@.", targetClassString, actionString];
        NSAssert(NO, errMsg);
        return nil;
    }
}

+ (void)NoTargetActionResponseWithTargetString:(NSString *)targetString selectorString:(NSString *)selectorString {
    NSString *errMsg = [NSString stringWithFormat:@"FHXRouterError:项目中未发现%@.", targetString];
    NSAssert(NO, errMsg);
}

+ (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params {

    NSMethodSignature *methodSig = [target methodSignatureForSelector:action];
    if (methodSig == nil) {
        return nil;
    }
    const char *retType = [methodSig methodReturnType];

    if (strcmp(retType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    }

    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(BOOL)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(CGFloat)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}

#pragma mark - Private Method

///根据URL分解出参数
+ (NSDictionary<NSString *, id> *)queryParameterFromURL:(NSURL *)URL {
    if (!URL) {
        return nil;
    }

    NSURLComponents *components = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:NO];

    NSArray <NSURLQueryItem *> *queryItems = [components queryItems] ?: @[];

    NSMutableDictionary *queryParams = @{}.mutableCopy;

    for (NSURLQueryItem *item in queryItems) {
        if (item.value == nil) {
            continue;
        }

        if (queryParams[item.name] == nil) {
            queryParams[item.name] = item.value;
        } else if ([queryParams[item.name] isKindOfClass:[NSArray class]]) {
            NSArray *values = (NSArray *) (queryParams[item.name]);
            queryParams[item.name] = [values arrayByAddingObject:item.value];
        } else {
            id existingValue = queryParams[item.name];
            queryParams[item.name] = @[existingValue, item.value];
        }
    }

    return queryParams.copy;
}

//把json解析为dictionary
+ (NSDictionary<NSString *, NSDictionary<NSString *, id> *> *)queryParameterFromJson:(NSString *)json {
    if (!json.length) {
        return nil;
    }
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if (error) {
        NSLog(@"FHXRouter [Error] Wrong URL Query Format: \n%@", error.description);
    }
    return dic;
}

+ (FHXRouterViewControlerEnterMode)viewControllerEnterMode:(NSString *)enterModePattern {
    enterModePattern = enterModePattern.lowercaseString;
    if ([enterModePattern isEqualToString:FHXURLFragmentViewControlerEnterModePush]) {
        return FHXRouterViewControlerEnterModePush;
    } else if ([enterModePattern isEqualToString:FHXURLFragmentViewControlerEnterModeModal]) {
        return FHXRouterViewControlerEnterModeModal;
    } else if ([enterModePattern isEqualToString:FHXURLFragmentViewControlerEnterModePop]) {//
        return FHXRouterViewControlerEnterModePop;
    } else if ([enterModePattern isEqualToString:FHXURLFragmentViewControlerEnterModeDismiss]) {
        return FHXRouterViewControlerEnterModeDismiss;
    }
    return FHXRouterViewControlerEnterModePush;
}

+ (NSDictionary<NSString *, id> *)solveURLParams:(NSDictionary<NSString *, id> *)URLParams
                                  withFuncParams:(NSDictionary<NSString *, id> *)funcParams
                                        forClass:(Class)mClass {
    if (!URLParams) {
        URLParams = @{};
    }
    NSMutableDictionary<NSString *, id> *params = URLParams.mutableCopy;
    NSArray<NSString *> *funcParamKeys = funcParams.allKeys;
    [funcParamKeys enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [params setObject:funcParams[obj] forKey:obj];
    }];

    return params;
}

+ (void)solveJumpWithViewController:(UIViewController *)viewController
                        andJumpMode:(FHXRouterViewControlerEnterMode)enterMode
                      shouldAnimate:(BOOL)animate {

    if (enterMode == FHXRouterViewControlerEnterModePush) {
        [[FHXRouter sharedInstance].currentNavigationController pushViewController:viewController animated:animate];
    } else if (enterMode == FHXRouterViewControlerEnterModeModal) {
        UIViewController *currViewController = [self currentViewController];
        [currViewController presentViewController:viewController animated:animate completion:^{

        }];
    } else if (enterMode == FHXRouterViewControlerEnterModePop) {
        [[FHXRouter sharedInstance].currentNavigationController popViewControllerAnimated:YES];
    } else if (enterMode == FHXRouterViewControlerEnterModeDismiss) {
        UIViewController *currViewController = [self currentViewController];
        [currViewController dismissViewControllerAnimated:YES completion:^{

        }];
    }
}

+ (UIViewController *)currentViewController {
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;

    while (viewController) {
        if ([viewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tbvc = (UITabBarController *) viewController;
            viewController = tbvc.selectedViewController;
        } else if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nvc = (UINavigationController *) viewController;
            viewController = nvc.topViewController;
        } else if (viewController.presentedViewController) {
            viewController = viewController.presentedViewController;
        } else if ([viewController isKindOfClass:[UISplitViewController class]] &&
                ((UISplitViewController *) viewController).viewControllers.count > 0) {
            UISplitViewController *svc = (UISplitViewController *) viewController;
            viewController = svc.viewControllers.lastObject;
        } else {
            return viewController;
        }
    }
    return viewController;
}

@end
