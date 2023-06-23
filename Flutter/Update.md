# 2023.6.23 

* fvm 升级 flutter 版本至 3.10.1 （原：3.0.5）
* 修改原 afjflutter 示例工程为 FlutterUnit 工程，相关 afjflutter 字段更新为 FlutterUnit

更新文件

* assets/*
* lib/*
* packages/*
* pubspec.yaml

更新配置

* pubspec.yaml

增加：

```
  # This section identifies your Flutter project as a module meant for
  # embedding in a native host app.  These identifiers should _not_ ordinarily
  # be changed after generation - they are used to ensure that the tooling can
  # maintain consistency when adding or modifying assets and plugins.
  # They also do not have any bearing on your native host application's
  # identifiers, which may be completely independent or the same as these.
  module:
    androidX: true
    androidPackage: com.example.afjandroid
    iosBundleIdentifier: com.alfred.AFJ-iOS
```
