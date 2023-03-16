import 'dart:io';

import 'package:app_config/app_config.dart';
import 'package:app_update/app_update.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afjflutter/painter_system/gallery_unit.dart';
import 'package:afjflutter/widget_ui/mobile/category_page/collect_page.dart';
import 'package:afjflutter/widget_ui/mobile/category_page/home_right_drawer.dart';
import 'package:old_fancy_mobile_ui/bloc/color_change_bloc.dart';

import 'package:old_fancy_mobile_ui/home_page/fancy_home_page.dart';
import 'package:old_fancy_mobile_ui/old_fancy_mobile_ui.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:afjflutter/widget_ui/mobile/widget_panel/standard_home_page.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import 'pure_bottom_bar.dart';
import 'desk_ui/unit_desk_navigation.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 主题结构 左右滑页 + 底部导航栏

class UnitNavigation extends StatelessWidget {
  const UnitNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (_, state) => LayoutBuilder(builder: (_, c) {
        if (c.maxWidth > 500) {
          return UnitDeskNavigation();
        }
        return UnitPhoneNavigation();
      }),
    );
  }
}

class UnitPhoneNavigation extends StatefulWidget {
  const UnitPhoneNavigation({Key? key}) : super(key: key);

  @override
  _UnitPhoneNavigationState createState() => _UnitPhoneNavigationState();
}

class _UnitPhoneNavigationState extends State<UnitPhoneNavigation> {
  //页面控制器，初始 0
  final PageController _controller = PageController();
  int position = 0;

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();

  final List<WidgetFamily> items = [
    WidgetFamily.statelessWidget,
    WidgetFamily.statefulWidget,
    WidgetFamily.singleChildRenderObjectWidget,
    WidgetFamily.multiChildRenderObjectWidget,
    WidgetFamily.sliver,
    WidgetFamily.proxyWidget,
    WidgetFamily.other,
  ];

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      BlocProvider.of<UpdateBloc>(context)
          .add(const CheckUpdate(appName: 'FlutterUnit'));
    }
  }

  @override
  void dispose() {
    _controller.dispose(); //释放控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppStyle style = context.read<AppBloc>().state.appStyle;
    bool isStandard = style == AppStyle.standard;
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterUnit"),
        actions: <Widget>[
          IconButton(
              onPressed: () => {
                    _launchInBrowser(
                        "https://github.com/toly1994328/FlutterUnit")
                  },
              icon: Icon(
                TolyIcon.icon_github,
                color: Colors.white,
              )),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Card(
                child: ListTile(
                  title: Text('搜索'),
                  onTap: () {
                    Navigator.of(context).pushNamed(UnitRouter.search);
                  },
                ),
              );
            } else {
              return _cellForRow(context, index - 1);
            }
          },
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;
    if (await launcher.canLaunch(url)) {
      await launcher.launch(
        url,
        useSafariVC: false,
        useWebView: false,
        enableJavaScript: false,
        enableDomStorage: false,
        universalLinksOnly: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }

  Widget _cellForRow(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(items[index].displayTitle),
        onTap: () {
          Navigator.of(context)
              .pushNamed(UnitRouter.standard_home, arguments: items[index]);
        },
      ),
    );
  }
}
