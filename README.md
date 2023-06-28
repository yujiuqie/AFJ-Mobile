# AFJ-Mobile

## 1. 工程简介

一个 iOS 示例 Demo，展示 iOS 开发中可能用到的一些技术，包括 ReactNative、Flutter、小程序、H5 混合开发示例。

## 2. 运行说明 

### 2.1 开发环境

|        工具        |     版本      | 备注  |
| :----------------: | :-----------: | :---: |
|       MacOS        |     12.6      |       |
|       Xcode        |    14.0.1     |       |
|   Android Studio   |   2021.1.1    |       |
|       gradle       |     6.6.1     |       |
| Visual Studio Code |    1.70.2     |       |
|       Unity        | 2021.3.6f1c1  |       |
|  JetBrains Rider   |   2022.1.2    |       |
|      Flutter       | 3.10.1(stable) |       |
|        Dart        |    2.17.6     |       |
|  react-native-cli  |     9.5.0     |       |
|       react        |     18.2.0    |       |
|    react-native    |     0.71.4    |       |
|       nodejs       |    18.15.0    |       |
|        npm         |     9.5.0     |       |
|        ruby        |     2.7.6     |       |
|     Cocoapods      |    1.12.0     |       |

### 2.2 初始化工程

打开 Mac 终端，进入工程根目录并执行 setup.sh 脚本

推荐安装 fvm、rvm、nvm，并确保使用 Flutter(3.10.1(stable))、nodejs(18.15.0)、ruby(2.7.6) 版本环境执行以下脚本

```shell
sh script/setup.sh
```

## 3. 参考链接

* [AFJ-iOS 介绍](https://jhfs.fun/008-res-dev-memo/%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0/2023/02/13/study-notes-sample-projects-afj-ios.html)
* [Mac 端研发终端工具软件版本管理工具](https://jhfs.fun/008-res-dev-memo/%E7%A0%94%E5%8F%91%E5%A4%87%E5%BF%98/2023/03/14/research-and-development-note-mac-dev-tools.html)

## 4. 引用组件及插件介绍

### 4.1 原生功能及插件

（基于 Pod，2023.2.14，dev-1.0.0 分支）

#### 4.1.1 原生三方相关

|工具|版本|说明|最后更新|备注|
| :---: | :---: | :---: | :---: | :---: |
|[ADTransitionController](https://github.com/applidium/ADTransitionController)|1.2.0|ADTransitionController 实现多种视图切换动画。包括滑动、旋转、淡出、交换、回形针等|Jun 21, 2018| -- |
|[AFNetworking](https://github.com/AFNetworking/AFNetworking)|4.0.1|一款轻量级网络请求开源框架|Jan 18, 2023| -- |
|[Aspects](https://github.com/steipete/Aspects)|1.4.1|是一个用于 AOP 的 Objective-C 库，不推荐生产环境使用|Feb 5, 2019| -- |
|[BEMCheckBox](https://github.com/Boris-Em/BEMCheckBox)|1.4.1|是一个开源库，可以轻松地为iOS创建漂亮，高度可定制的，有动画效果的复选框。|Oct 2, 2020| -- |
|[BabyBluetooth](https://github.com/coolnameismy/BabyBluetooth)|0.7.0|BabyBluetooth是一个最简单易用的蓝牙库，基于CoreBluetooth的封装，并兼容ios和mac osx。|Mar 15, 2017| -- |
|[BlocksKit](https://github.com/BlocksKit/BlocksKit)|2.2.5|是对Cocoa Touch Block编程更进一步的支持,它简化了Block编程,发挥Block的相关优势,让更多UIKit类支持Block式编程。|Jun 2, 2018（Archived）| -- |
|[CLImageEditor](https://github.com/yackle/CLImageEditor)|0.2.4|一个 iOS 图像编辑控件,提供基本的图像编辑功能| Feb 8, 2022| -- |
|[CRToast](https://github.com/cruffenach/CRToast)|0.0.9|用来简单创建出现在导航栏或者状态栏上的通知，基于另一个开源项目CWStatusBarNotification。使用ARC。|Mar 12, 2017| -- |
|[CYLTabBarController](https://github.com/ChenYilong/CYLTabBarController)|1.29.2|【中国特色 TabBar】一行代码实现 Lottie 动画TabBar，支持中间带+号的TabBar样式，自带红点角标，支持动态刷新。|Aug 30, 2021| -- |
|[ChameleonFramework](https://github.com/vicc/chameleon)|2.1.0|一个轻量级，强大的扁平颜色iOS框架(Objective-C＆Swift)|Jun 13, 2021（Archived）| -- |
|[Charts](https://github.com/danielgindi/Charts)|4.1.0|一套非常漂亮的开源图表组件，它是MPAndroidChart在苹果端的移植版本，同时支持iOS/tvOS/OSX平台。 Charts是用 Swift语言编写的，能够同时在 Swift 和 Objc 工程中使用。|Sep 13, 2022| -- |
|[CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack)|3.6.0|一个可以在iOS和Mac开发中使用的日志库，强大又不失灵活。集成进项目后，可以灵活控制日志level输出，并保存在日志文件中，还能压缩上传到服务器。|Jan 31, 2023| -- |
|[DZNEmptyDataSet](https://github.com/dzenbot/DZNEmptyDataSet)|1.8.1|一个嵌入 UITableView/UICollectionView 超类的范畴(category),当视图没有要显示的内容时,它用于显示空数据集界面。|Nov 30, 2022（Archived）| -- |
|[DateTools](https://github.com/MatthewYork/DateTools)|2.0.0|Objective-C中简化日期和时间处理的工具，让NSDate功能更完整,可以让你更容易地去获取日期各个组件的信息,如年 月 日等。|Jan 31, 2020| -- |
|[EasyShowView](https://github.com/chenliangloveyou/EasyShowView)|2.1.4|一款非常简单的展示工具。提示框，加载框，空白页提示，alert弹出框。一行代码搞定所有操作。|Sep 17, 2018| -- |
|[FBAllocationTracker](https://github.com/facebookarchive/FBAllocationTracker)|0.1.5|--|Jan 13, 2022（Archived）| -- |
|[FBMemoryProfiler](https://github.com/facebookarchive/FBMemoryProfiler)|0.1.3|一款Facebook出品并开源的帮助分析iOS内存使用情况的iOS工具|Jun 2, 2021（Archived）| -- |
|[FBRetainCycleDetector](https://github.com/facebook/FBRetainCycleDetector)|0.1.4|一款Facebook出品并开源的一套检测循环引用的库|Sep 24, 2022| -- |
|[FCUUID](https://github.com/fabiocaccamo/FCUUID)|1.3.1|获取设备标识符|Dec 13, 2022| -- |
|[FDFullscreenPopGesture](https://github.com/forkingdog/FDFullscreenPopGesture)|1.1|支持应用所有页面全屏侧滑。|Jun 13, 2017| -- |
|[FLAnimatedImage](https://github.com/Flipboard/FLAnimatedImage)|1.0.17|是由Flipboard开源的iOS平台上播放GIF动画的一个优秀解决方案,在内存占用和播放体验都有不错的表现。|Jul 28, 2022| -- |
|[FLEX](https://github.com/FLEXTool/FLEX)|4.1.1|FLEX是Flipboard官方发布的一组专门用于iOS开发的应用内调试工具，能在模拟器和物理设备上良好运作，而开发者也无需将其连接到LLDB/Xcode或其他远程调试服务器，即可直接查看或修改正在运行的App的每一处状态。|Dec 9, 2022| -- |
|[FMDB](https://github.com/ccgus/fmdb)|2.7.5|是针对libsqlite3框架进行封装的三方，它以OC的方式封装了SQLite的C语言的API，使用步骤与SQLite相似。|Oct 7, 2022| -- |
|[FSCalendar](https://github.com/WenchaoD/FSCalendar)|2.8.4|是开源iOS日历控件,支持横向、纵向滑动. 月模式,周模式. 显示农历,标记时间.定制时间范围.选择事件等多种需求. |Nov 3, 2022| -- |
|[FXBlurView](https://github.com/nicklockwood/FXBlurView)|1.6.4|帮助实现毛玻璃效果|Oct 26, 2017| -- |
|[GBDeviceInfo](https://github.com/lmirosevic/GBDeviceInfo)|6.7.0|帮助获取设备相关信息|Jan 27, 2023| -- |
|[GPJDataDrivenTableView](https://github.com/gongpengjun/GPJDataDrivenTableView)|0.6.2|一种便捷创建 tableview 的框架|Jan 11, 2019| -- |
|[GPUImage](https://github.com/BradLarson/GPUImage)|0.1.7|用于基于GPU的图像和视频处理的开源iOS框架|May 26, 2016| -- |
|[GVUserDefaults](https://github.com/getsling/GVUserDefaults)|1.0.2|用户偏好设置的封装库|Jan 19, 2016| -- |
|[HJDanmaku](https://github.com/panghaijiao/HJDanmakuDemo)|2.0.6|一个高性能的 iOS 弹幕引擎|Jul 9, 2020| -- |
|[IJKMediaFramework](https://gitee.com/renzifeng/IJKMediaFramework)|0.1.5|直播视频拉流 SDK|--| -- |
|[INTULocationManager](https://github.com/intuit/LocationManager)|4.4.0|便捷获取 iOS 设备当前位置库|Oct 10, 2019| -- |
|[IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager)|6.5.10|可以防止键盘滑动问题和覆盖UITextField / UITextView无需你输入任何代码,不需要额外的设置要求。|Jan 11, 2023| -- |
|[ISHPermissionKit](https://github.com/iosphere/ISHPermissionKit)|2.1.3|为 iOS 提供请求用户权限的统一方法|Jan 8, 2021| -- |
|[JDStatusBarNotification](https://github.com/calimarkus/JDStatusBarNotification)|2.0.6|用以在顶部的状态栏展示信息。可自定义颜色、字体以及动画。支持进度条展示,并可以显示活动指示器。|Sep 27, 2022| -- |
|[JLRoutes](https://github.com/joeldev/JLRoutes)|2.1|iOS 组件化路由工具|Aug 11, 2021| -- |
|[JVFloatLabeledTextField](http://github.com/jverdi/JVFloatLabeledTextField)|1.2.2|JVFloatLabeledTextField 是 UITextField 的子类，实现了浮动效果的文本标签|Jul 12, 2021| -- |
|[JXBWebKit](https://github.com/xiubojin/JXBWKWebView)|1.3.0|iOS基于WKWebView的二次封装库|Oct 27, 2020| -- |
|[JXCategoryView](https://github.com/pujiaxin33/JXCategoryView)|1.6.1|腾讯新闻、今日头条、QQ音乐、网易云音乐、京东、爱奇艺、腾讯视频、淘宝、天猫、简书、微博等所有主流APP分类切换滚动视图。|Jul 17, 2022| -- |
|[KWTransition](https://github.com/KurtWagner/KWTransition)|0.0.4|帮助实现 iOS UIViewController 各类转场动画|Mar 21, 2014| -- |
|[LBXScan](https://github.com/MxABC/LBXScan)|2.5.1|二维码、扫码、扫一扫、ZXing、ZBar、iOS系统AVFoundation扫码封装，扫码界面效果封装。|Oct 16, 2020| -- |
|[LBXZBarSDK](https://github.com/MxABC/LBXZBarSDK)|1.3.5|删除 UIWebView 的扫码库 SDK|Sep 2, 2020| -- |
|[LCZoomTransition](https://github.com/mluisbrown/LCZoomTransition)|1.0.0|UIViewController 缩放过渡工具库|Jan 22, 2015 | -- |
|[LSAnimator](https://github.com/Lision/LSAnimator)|2.1.5|易于读写的多链式动画框架，可以用少量的代码实现复杂而又易于维护的动画。|Aug 12, 2021| -- |
|[LSSafeProtector](https://github.com/lsmakethebest/LSSafeProtector)|2.1.4|强大的防止crash框架，不改变原代码支持KVO自释放，可以检测到dealloc时未释放的kvo，等19种crash|Jul 27, 2019| -- |
|[LSTCategory](https://github.com/LoSenTrad/LSTCategory)|0.3.2|LSTCategory是一个分类集合通用组件|Nov 18, 2021| -- |
|[LSTPopView](https://github.com/LoSenTrad/LSTPopView)|0.3.10|iOS万能弹窗。|Mar 16, 2021| -- |
|[LSTTimer](https://github.com/LoSenTrad/LSTTimer)|0.2.10|一个性能和精度兼得的iOS计时器组件|Mar 23, 2021| -- |
|[MBProgressHUD](https://github.com/jdg/MBProgressHUD)|1.2.0|实现了很多种样式的提示框,使用上简单、方便,并且可以对显示的内容进行自定义,功能很强大,很多项目中都有使用到。|Nov 25, 2020| -- |
|[MGSwipeTableCell](https://github.com/MortimerGoro/MGSwipeTableCell)|1.6.14|第三方 cell 侧滑支持库|Nov 25, 2020| -- |
|[MJExtension](https://github.com/CoderMJLee/MJExtension)|3.4.1|利用Obj-C的运行时机制编写数据解析Json框架。|Dec 6, 2021| -- |
|[MJRefresh](https://github.com/CoderMJLee/MJRefresh)|3.7.5|可高度自定义的刷新第三方框架。|Oct 10, 2022| -- |
|[MLeaksFinder](https://github.com/Zepo/MLeaksFinder)|1.0.0|一个 iOS 平台的自动内存泄漏检测工具|Jan 10, 2022 | -- |
|[MMDrawerController](https://github.com/mutualmobile/MMDrawerController)|0.6.0|一个轻量级的侧边栏抽屉控件,其支持左侧抽屉和右侧抽屉,可以很好的支持导航控制器,并且支持开发者对手势和动画进行自定义。|May 9, 2015| -- |
|[MOFSPickerManager](https://github.com/memoriesofsnows/MOFSPickerManagerDemo)|3.0.1|iOS PickerView整合，一行代码调用（省市区三级联动+日期选择+普通选择）|May 11, 2022| -- |
|[MQTTClient](https://github.com/novastone-media/MQTT-Client-Framework)|0.15.3|MQTT 是轻量的(Lightweight)、发布订阅模式(PubSub) 的物联网消息协议。|Feb 26, 2020| -- |
|[MTAppenderFile](https://github.com/meitu/MTAppenderFile)|0.4.4|MTHawkeye 支持工具，实现高性能日志收集和展示|Sep 29, 2020| -- |
|[MTBBarcodeScanner](https://github.com/mikebuss/MTBBarcodeScanner)|5.0.11|一款二维码扫码工具库|Feb 25, 2021| -- |
|[MTGLDebug](https://github.com/meitu/MTGLDebug)|3.1.2|MTHawkeye 支持工具，实现 OpenGL 资源内存占用|Jul 26, 2019| -- |
|[MTHawkeye](https://github.com/meitu/MTHawkeye)|0.12.5|适用于iOS的性能分析/调试辅助工具。（内存泄漏，OOM，ANR，硬停顿，网络，OpenGL，时间配置文件...）|Nov 1, 2022| -- |
|[MagicalRecord](https://github.com/magicalpanda/MagicalRecord)|2.3.2|是对CoreData进行了一次封装，封装了多线程Core Data中复杂的操作，并提供了丰富的封装方法，使用起来代码清晰简洁。|Dec 21, 2019| -- |
|[Mantle](https://github.com/Mantle/Mantle)|2.2.0|面向 Cocoa 和 Cocoa Touch 的模型框架 Model。Github 官方团队开发的 JSON 模型转换库，Model 需要继承自 MTLModel。|Oct 18, 2022| -- |
|[MotionBlur](https://github.com/fastred/MotionBlur)|0.2.0|允许您向iOS动画添加运动模糊效果。|Apr 5, 2015（Archived）| -- |
|[NBSwipePageView](https://github.com/xuzhe/NBSwipePageView)|0.1|页面切换工具库|Sep 13, 2015 | -- |
|[NerdyUI](https://github.com/nerdycat/NerdyUI)|1.2.1|UI 开发相关辅助工具库|Apr 18, 2019| -- |
|[OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs)|9.1.0|轻松添加您的网络请求！使用伪造的网络数据和自定义响应时间，响应代码和标头测试您的应用！|Dec 2, 2020| -- |
|[Onboard](https://github.com/mamaral/Onboard)|2.3.3|使用几行代码就能轻松创建创建优美而迷人的引导页。|Mar 30, 2018| -- |
|[PINCache](https://github.com/pinterest/PINCache)|3.0.3|一款 iOS 高效缓存库|Oct 27, 2022| -- |
|[PINOperation](https://github.com/pinterest/PINOperation)|1.2.1|支持 iOS 和 macOS 的快速并发受限任务队列。|Nov 29, 2022 | -- |
|[PINRemoteImage](https://github.com/pinterest/PINRemoteImage)|3.0.3|一款线程安全、高性能、功能丰富的 iOS 图片请求工具|Mar 3, 2022| -- |
|[PMTween](https://github.com/poetmountain/PMTween)|1.3.7|一款动画支持工具。|Jul 20, 2016| -- |
|[PPNumberButton](https://github.com/jkpang/PPNumberButton)|0.8.0|一款高度可定制性商品计数按钮|Aug 23, 2019| -- |
|[PYSearch](https://github.com/ko1o/PYSearch)|0.9.1|一个非常优雅的搜索控制器iOS框架|Aug 6, 2020| -- |
|[PinYin4Objc](https://github.com/kimziv/PinYin4Objc)|1.1.1|是一种流行的Objective-C库，支持中文（简体和繁体）与大多数流行的拼音系统之间的转换，它的性能非常高效，首次缓存了数据，并使用带有块的异步方法，这可以避免ui阻塞，并顺利运行。拼音的输出格式可以自定义。|Oct 8, 2013| -- |
|[QMUIKit](https://qmuiteam.com/ios)|4.5.1|QMUI iOS——致力于提高项目 UI 开发效率的解决方案|Dec 15, 2022| -- |
|[QTEventBus](https://github.com/LeoMobileDeveloper/QTEventBus)|0.4.1|一个优雅的iOS事件总线，用来实现“发布-订阅”的消息通信模式|Dec 14, 2020| -- |
|[REFormattedNumberField](https://github.com/romaonthego/REFormattedNumberField)|1.1.6|一个 UITextField 的子类，实现了数据的格式化输入。|Mar 14, 2016| -- |
|[RETableViewManager](https://github.com/romaonthego/RETableViewManager)|1.7|强大的数据驱动的UITableView内容管理器。|May 4, 2016| -- |
|[REValidation](https://github.com/romaonthego/REValidation)|0.1.4|Objective-C 对象校验工具|Jan 10, 2015| -- |
|[RKNotificationHub](https://github.com/cwRichardKim/RKNotificationHub)|2.0.5|快速给 UIView 添加上炫酷的通知图标(Badge、红点、提示)。|Nov 3, 2018| -- |
|[ReachabilitySwift](https://github.com/ashleymills/Reachability.swift)|5.0.0|iOS 网络状态监测 Swift 版本|Oct 31, 2020| -- |
|[ReactiveObjC](https://github.com/ReactiveCocoa/ReactiveObjC)|3.1.1|ReactiveObjC是ReactiveCocoa系列的一个OC方面用得很多的响应式编程三方框架，其Swift方面的框架是（ReactiveSwift）。|Apr 30, 2019| -- |
|[RegexKitLite](http://regexkit.sourceforge.net/RegexKitLite/)|4.0|一款强大的第三方正则表达式库。|Apr 8, 2010| -- |
|[SDCycleScrollView](https://github.com/gsdios/SDCycleScrollView)|1.82|简单好用的 无限循环轮播工具。|Mar 19, 2021| -- |
|[SDWebImage](https://github.com/rs/SDWebImage)|5.13.2|一个可管理远程图片异步加载并缓存的类库。这个类库提供一个UIImageView类别以支持加载来自网络的远程图片。具有缓存管理、异步下载、同一个URL下载次数控制和优化等特征。|Feb 7, 2023| -- |
|[SSZipArchive](https://github.com/ZipArchive/ZipArchive)|2.4.3|一款 iOS 平台压缩解压缩工具库。|Dec 18, 2022| -- |
|[SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD)|2.2.5|iOS 进度组件库|Mar 8, 2021| -- |
|[SandBoxPreviewTool](https://github.com/wjyx1lalala/SandBoxPreviewTool)|1.2.2|一行代码查看ios磁盘沙盒文件。debug好助手|Nov 18, 2020| -- |
|[Sandboxer](https://github.com/meilbn/Sandboxer-Objc)|1.1.0|Sandboxer 是用来在 iOS 设备上查看沙盒目录内容的，支持 3D Touch 预览，文件搜索等，方便调试，可以查看一些文件内容，也可以分享出来，方便在电脑上查看。|Jun 20, 2020| -- |
|[Shimmer](https://github.com/facebook/Shimmer)|1.0.2|是一款开源的加载效果工具,能够非常简单地向应用中的任何视图添加闪闪发光的字体效果,并且不会显得突兀。|Jan 29, 2020（Archived）| -- |
|[SocketRocket](https://github.com/facebookarchive/SocketRocket)|0.6.0|符合标准的Objective-C WebSocket客户端库。|Aug 13, 2021| -- |
|[StreamingKit](https://github.com/tumtumtum/StreamingKit)|0.1.30|是一个强大的IOS音频播放工具|Jun 1, 2022| -- |
|[SwiftAlgorithms](https://github.com/apple/swift-algorithms)|1.0.0|一系列关于序列 (sequence) 和集合 (collection) 类型及相关类型的算法包。|Dec 8, 2022| -- |
|[SwiftyStoreKit](https://github.com/bizz84/SwiftyStoreKit)|0.16.1|一款 Swift 内购支持工具|Jan 20, 2023| -- |
|[TOCropViewController](https://github.com/TimOliver/TOCropViewController)|2.6.1|适用于iOS的视图控制器，允许用户裁剪UIImage对象的部分。|Aug 6, 2022| -- |
|[TTGTagCollectionView](https://github.com/zekunyan/TTGTagCollectionView)|2.1.0|一种标签流显示控件，同时支持文字或自定义View。|Sep 16, 2022| -- |
|[TYAlertController](https://github.com/12207480/TYAlertController)|1.2.0|各种风格的弹框，满足你的各种需求。|Apr 29, 2018| -- |
|[TYPagerController](https://github.com/12207480/TYPagerController)|2.1.2|TYPagerController 简单，强大，高度定制，页面控制器,水平滚动内容和标题栏,包含多种barStyle。|May 8, 2019| -- |
|[TZImagePickerController](https://github.com/banchichen/TZImagePickerController)|3.8.3|一个支持多选、选原图和视频的图片选择器，同时有预览、裁剪功能，支持iOS6+。|Jan 1, 2023| -- |
|[Toast](https://github.com/scalessec/Toast)|4.0.0|iOS 提示框封控库|May 8, 2019| -- |
|[UIAlertController+Blocks](https://github.com/ryanmaxwell/UIAlertController-Blocks)|0.9.2|对UIAlertViewController 进行了封装,支持用 Blocks 方式封装的便捷扩展类,调用更简单。|May 23, 2017| -- |
|[UICKeyChainStore](https://github.com/kishikawakatsumi/UICKeyChainStore)|2.1.2|对于一些私密信息，比如密码、证书等等，就需要使用更为安全的数据保存方式。|Sep 19, 2020| -- |
|[UITableView-FDTemplateLayoutCell](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)|1.6|一个由国人团队开发的优化计算 UITableViewCell 高度的轻量级框架，由于实现逻辑简明清晰，代码也不复杂，非常适合作为新手学习其他著名却庞大的开源项目的“入门教材”。|Nov 19, 2017| -- |
|[VCTransitionsLibrary](https://github.com/ColinEberhardt/VCTransitionsLibrary)|1.5.0|自定义iOS交互式转场动画的库|May 31, 2016| -- |
|[YXYDashLayer](https://github.com/yulingtianxia/YXYDashLayer)|1.0.0|多彩的圆角矩形Dash边框工具。|May 15, 2018| -- |
|[YYKit](https://github.com/ibireme/YYKit)|1.0.9|一套 iOS 开发工具库。|Aug 6, 2017| -- |
|[YYModel](https://github.com/ibireme/YYModel)|1.0.4|数据解析Json框架，支持自动的 JSON/Model 转换，支持定义映射过程。|Jan 1, 2023| -- |
|[Yoga](https://github.com/facebook/yoga)|1.14.0|实现Flexbox的跨平台布局引擎|Feb 15, 2023| -- |
|[ZFPlayer](https://github.com/renzifeng/ZFPlayer)|4.0.3|是一款基于AVPlayer,支持横屏、竖屏(全屏播放还可锁定屏幕方向),上下滑动调节音量、屏幕亮度,左右滑动调节播放进度的视频播放器软件。|Jan 6, 2023| -- |
|[ZJAnimationPopView](https://github.com/Abnerzj/ZJAnimationPopView)|1.0.5|一个快速便捷、无侵入、可扩展的动画弹框库，两句代码即可实现想要的动画弹框。支持手写和xib，支持横竖屏。可以配置出72种不同的弹框动画效果。|Oct 27, 2020| -- |
|[ZLCollectionViewFlowLayout](https://github.com/czl0325/ZLCollectionView)|1.4.7|基于UICollectionView实现，目前支持标签布局，列布局，百分比布局，定位布局，填充式布局，瀑布流布局等。支持纵向布局和横向布局，可以根据不同的section设置不同的布局，支持拖动cell，头部悬浮，设置section背景色和自定义section背景view，向自定义背景view传递自定义方法。|Jan 5, 2023| -- |
|[ZSSRichTextEditor](https://github.com/nnhubbard/ZSSRichTextEditor)|0.5.2.2|用于iOS的漂亮的RTF所见即所得编辑器，带有突出显示语法的源代码视图|Sep 8, 2021| -- |
|[ZipArchive](https://github.com/mattconnolly/ZipArchive)|1.4.0|zip 文件读取工具库。|Oct 20, 2017| -- |
|[dsBridge](https://github.com/wendux/DSBridge-IOS)|3.0.6|一个用来用来原生和h5交互的轻量级框架|Nov 19, 2018| -- |
|[fishhook](https://github.com/facebook/fishhook)|0.2|fishhook是Facebook推出的一个轻量级hook框架|Oct 13, 2021| -- |
|[lottie-ios](https://github.com/airbnb/lottie-ios)|2.5.3|一个用于本机渲染 After Effects 矢量动画的 iOS 工具库。|Feb 16, 2023| -- |
|[Pop](https://github.com/facebook/pop)|1.0.12|Facebook发布的动画引擎，用以扩展iOS、OSX的动画类型。相较于iOS、OSX中的基本动画效果，Pop扩展后支持弹簧动画效果与衰减动画效果，你可以用Pop动画引擎来构建出真实的物理交互效果。|Oct 12, 2018| -- |
|[zhPopupController](https://github.com/snail-z/zhPopupController)|1.0.3|一款封装了多种类型弹框的工具库。|Apr 3, 2020| -- |

#### 4.1.2 阿里相关服务

|工具|版本|说明|最后更新|备注|
| :---: | :---: | :---: | :---: | :---: |
|AMap3DMap-NO-IDFA|9.4.0|高德地图无IDFA版 SDK|--| -- |
|AMapFoundation-NO-IDFA|1.7.0|高德地图无IDFA版 SDK|--| -- |
|AMapLocation-NO-IDFA|2.9.0|高德地图无IDFA版定位 SDK|--| -- |
|AMapSearch-NO-IDFA|9.4.0|高德地图无IDFA版搜索 SDK|--| -- |
|AliAPMInterface|1.0.1.12|--|--| -- |
|AliCloudNetworkMonitor|1.0.0|--|--| -- |
|AliCrashReporterInterface|0.0.5|--|--| -- |
|AliHACore|10.0.3.6|--|--| -- |
|AliHADataHub4iOS|1.0.1.24|--|--| -- |
|AliHADataHubAssembler|1.0.1.46-downgrade|--|--| -- |
|AliHADeviceEvaluation|10.0.3.8|--|--| -- |
|AliHALogEngine|10.0.5|--|--| -- |
|AliHAMemoryMonitor|10.0.3|--|--| -- |
|AliHAMethodTrace|10.0.4|--|--| -- |
|AliHAPerformanceMonitor|10.0.3.2-NO-UT|--|--| -- |
|AliHAProtocol|10.0.3|--|--| -- |
|AliHASecurity|10.0.4|--|--| -- |
|AliRemoteDebugInterface|0.0.1.4|--|--| -- |
|AlicloudAPM|1.1.1|--|--| -- |
|AlicloudCrash|1.2.0|--|--| -- |
|AlicloudHAUtil|1.0.1|--|--| -- |
|AlicloudSettingService|1.0.0|--|--| -- |
|AlicloudTLog|1.0.1.1|--|--| -- |
|AlicloudUTDID|1.5.0.94|--|--| -- |
|AlicloudUtils|1.3.9|--|--| -- |
|AliyunOSSiOS|2.10.15|--|--| -- |
|BizErrorReporter4iOS|10.0.3|--|--| -- |
|CrashReporter|10.0.3|阿里云崩溃数据收集 SDK|--| -- |
|EMASRest|11.1.1.2|--|--| -- |
|JDYThreadTrace|11.1.1.2|--|--| -- |
|KSCrashTao|1.0.4.0|--|--| -- |
|RemoteDebugChannel|10.0.4.5|--|--| -- |
|TBCrashReporter|10.2.0.1|--|--| -- |
|TBJSONModel|0.1.15.1|--|--| -- |
|TBRest|10.1.1.0|--|--| -- |
|TRemoteDebugger|10.0.6.4|--|--| -- |

#### 4.1.3 腾讯相关服务

|工具|版本|说明|最后更新|备注|
| :---: | :---: | :---: | :---: | :---: |
|Bugly|2.5.93|腾讯 Bugyly SDK|--| -- |
|WechatOpenSDK|1.8.4|--|--| -- |

#### 4.1.4 百度相关服务

|工具|版本|说明|最后更新|备注|
| :---: | :---: | :---: | :---: | :---: |
|BMKLocationKit|2.0.4|百度地图定位 SDK|--| -- |
|BaiduMapKit|6.3.0|百度地图 SDK|--| -- |

#### 4.1.5 Cordova 相关服务

|工具|版本|说明|最后更新|备注|
| :---: | :---: | :---: | :---: | :---: |
|Cordova|5.1.1|Cordova 框架 SDK|--| -- |
|cordova-plugin-wkwebview-engine|1.1.0|--|--| -- |

#### 4.1.6 友盟相关服务

|工具|版本|说明|最后更新|备注|
| :---: | :---: | :---: | :---: | :---: |
|UMAPM|1.7.0|--|--| -- |
|UMCommon|7.3.7|--|--| -- |
|UMDevice|2.2.1|--|--| -- |

#### 4.1.7 React Native 相关服务

|工具|版本|说明|最后更新|备注|
| :---: | :---: | :---: | :---: | :---: |
|React|0.66.2|--|--| -- |
|React-Core|0.66.2|--|--| -- |
|React-CoreModules|0.66.2|--|--| -- |
|React-RCTActionSheet|0.66.2|--|--| -- |
|React-RCTAnimation|0.66.2|--|--| -- |
|React-RCTBlob|0.66.2|--|--| -- |
|React-RCTImage|0.66.2|--|--| -- |
|React-RCTLinking|0.66.2|--|--| -- |
|React-RCTNetwork|0.66.2|--|--| -- |
|React-RCTSettings|0.66.2|--|--| -- |
|React-RCTText|0.66.2|--|--| -- |
|React-RCTVibration|0.66.2|--|--| -- |
|React-callinvoker|0.66.2|--|--| -- |
|React-cxxreact|0.66.2|--|--| -- |
|React-jsi|0.66.2|--|--| -- |
|React-jsiexecutor|0.66.2|--|--| -- |
|React-jsinspector|0.66.2|--|--| -- |
|React-logger|0.66.2|--|--| -- |
|React-perflogger|0.66.2|--|--| -- |
|React-runtimeexecutor|0.66.2|--|--| -- |
|ReactCommon|0.66.2|--|--| -- |
|DoubleConversion|1.1.6|Efficient binary-decimal and decimal-binary conversion routines for IEEE doubles.|--| ReactNative |
|FBLazyVector|0.66.2|--|--| -- |
|FBReactNativeSpec|0.66.2|--|--| -- |
|react-native-netinfo|5.9.10|--|--| -- |
|react-native-safe-area-context|3.4.1|--|--| -- |
|react-native-webview|11.23.0|--|--| -- |
|RCT-Folly|2021.06.28.00-v2|--|--| -- |
|RCTRequired|0.66.2|--|--| -- |
|RCTTypeSafety|0.66.2|--|--| -- |
|RNCAsyncStorage|1.12.1|--|--| -- |
|RNCMaskedView|0.1.11|--|--| -- |
|RNDeviceInfo|6.2.1|--|--| -- |
|RNGestureHandler|1.10.3|--|--| -- |
|RNImageCropPicker|0.35.3|--|--| -- |
|RNReanimated|1.13.4|--|--| -- |
|RNScreens|2.18.1|--|--| -- |
|boost|1.76.0|--|--| -- |
|fmt|6.2.1|--|--| -- |
|image_picker_ios|0.0.1|--|--| -- |

#### 4.1.8 Flutter 相关服务

|工具|版本|说明|最后更新|备注|
| :---: | :---: | :---: | :---: | :---: |
|Flutter|1.0.0|--|--| -- |
|FlutterPluginRegistrant|0.0.1|--|--| -- |
|ai_barcode|0.0.1|--|--| -- |
|connectivity_plus|0.0.1|--|--| -- |
|glog|0.3.5|--|--| -- |
|permission_handler_apple|9.0.4|--|--| -- |
|shared_preferences_ios|0.0.1|--|--| -- |
|url_launcher_ios|0.0.1|--|--| -- |
|video_player_avfoundation|0.0.1|--|--| -- |
|webview_flutter_wkwebview|0.0.1|--|--| -- |

#### 4.1.9 小程序相关服务

|工具|版本|说明|最后更新|备注|
| :---: | :---: | :---: | :---: | :---: |
|FinApplet|2.37.13|--|--| -- |
|FinAppletBDMap|2.37.13|--|--| -- |
|FinAppletBLE|2.37.13|--|--| -- |
|FinAppletClipBoard|2.37.13|--|--| -- |
|FinAppletContact|2.37.13|--|--| -- |
|FinAppletExt|2.37.13|--|--| -- |
|FinAppletGDMap|2.37.13|--|--| -- |
|FinAppletWebRTC|2.37.13|--|--| -- |
|[GoogleWebRTC](https://webrtc.org/)|1.1.26989|WebRTC iOS SDK|--| -- |