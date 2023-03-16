//
//  OveralHeader.h
//  Frame
//
//  Created by 冯汉栩 on 2021/2/8.
//

//#ifndef OveralHeader_h
//#define OveralHeader_h

//如果有新出的机型打开模拟器 截图查看尺寸(就知道新机型的分辨率)，填上去就可以了。
#define isSE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPhone ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone11 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone11Pro ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone11ProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

//1170, 2532
#define IPhone12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//1170, 2532
#define IPhone12Pro ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//1284, 2778
#define iPhone12ProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)


//这里用到的不外乎两种 1:用于设置高度 2:用于约束距离之外
//keyWindow
//#define win [UIApplication sharedApplication].keyWindow
///状态栏的高度
#define statusHight [[UIApplication sharedApplication] statusBarFrame].size.height
///获取导航栏
#define navHight self.navigationController.navigationBar.frame.size.height
///顶部安全距离
/*使用时注意  topSafeH 相加减要加括号 例如:Phone_Height - headerViewHeight - (topSafeH)*/
#define topSafeH statusHight + navHight
//底部安全距离
#define bottomSafeHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20.0?34.0:0.0)

//屏幕高度
#define Phone_Height [[UIScreen mainScreen] bounds].size.height
//屏幕宽度
#define Phone_Width [[UIScreen mainScreen] bounds].size.width
// 约束底部安全距离之上   加上tabbar
#define tabBarAndSafeHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

//获取当前版本
#define iosVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//判断是否是刘海屏
#define kIsNotchScreen ({\
    BOOL isBangsScreen = NO; \
    if (@available(iOS 11.0, *)) { \
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
    isBangsScreen = window.safeAreaInsets.bottom > 0; \
    } \
    isBangsScreen; \
})

//底部导航栏高度
#define kTabBarHeight (CGFloat)(kISNotchScreen?(49.0 + 34.0):(49.0))

#define WeakObj(o) try{}@finally{} __weak typeof(o) o##Weak = o;
/** 使用
 @WeakObj(self);
 selfWeak.XXXX
 */
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#ifdef DEBUG
//DEBUG模式下 打印日志 具体显示到那个控制器哪一行
#define DEBUGLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
//relsase模式下 不打印日志
#define DEBUGLog(...)
#endif





