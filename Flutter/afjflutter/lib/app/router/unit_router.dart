// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:app_config/app_config.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:afjflutter/app/navigation/unit_navigation.dart';
import 'package:afjflutter/app/views/about/about_app_page.dart';
import 'package:afjflutter/app/views/about/about_me_page.dart';
import 'package:afjflutter/app/views/about/version_info.dart';
import 'package:afjflutter/app/views/data_manage/data_manage_page.dart';
import 'package:afjflutter/app/views/setting/code_style_setting.dart';
import 'package:afjflutter/app/views/setting/font_setting.dart';
import 'package:afjflutter/app/views/setting/item_style_setting.dart';
import 'package:afjflutter/app/views/setting/setting_page.dart';
import 'package:afjflutter/app/views/setting/theme_color_setting.dart';
import 'package:afjflutter/app/views/unit_todo/attr_unit_page.dart';
import 'package:afjflutter/app/views/unit_todo/layout_unit_page.dart';
import 'package:afjflutter/app/views/unit_todo/point_unit_page.dart';
import 'package:afjflutter/point_system/views/issues_point/issues_detail.dart';
import 'package:afjflutter/point_system/views/issues_point/issues_point_page.dart';
import 'package:afjflutter/widget_ui/desk_ui/widget_detail/widget_detail_page.dart';
import 'package:afjflutter/widget_ui/mobile/category_page/category_detail.dart';
import 'package:afjflutter/widget_ui/mobile/category_page/collect_page.dart';
import 'package:afjflutter/widget_ui/mobile/search_page/search_page.dart';
import 'package:afjflutter/widget_ui/mobile/widget_detail/widget_detail_page.dart';
import 'package:old_fancy_mobile_ui/home_page/fancy_home_page.dart';
import 'package:widget_repository/widget_repository.dart';

import '../../painter_system/gallery_unit.dart';
import '../../widget_ui/mobile/widget_panel/standard_home_page.dart';

class UnitRouters {
  static const String widget_detail = '/widget_detail';

  static const String detail = 'detail';
  static const String search = 'search_bloc';
  static const String fancy_home = 'fancy_home';
  static const String standard_home = 'standard_home';
  static const String gallery_unit = 'gallery_unit';
  static const String user_page = 'user_page';

  static const String collect = 'CollectPage';
  static const String point = 'IssuesPointPage';
  static const String point_detail = 'IssuesDetailPage';

  static const String setting = 'SettingPage';
  static const String font_setting = 'FountSettingPage';
  static const String theme_color_setting = 'ThemeColorSettingPage';
  static const String code_style_setting = 'CodeStyleSettingPage';
  static const String item_style_setting = 'ItemStyleSettingPage';
  static const String version_info = 'VersionInfo';
  static const String login = 'login';

  static const String category_show = 'CategoryShow';
  static const String issues_point = 'IssuesPointPage';

  static const String attr = 'AttrUnitPage';
  static const String bug = 'BugUnitPage';
  static const String layout = 'LayoutUnitPage';
  static const String about_me = 'AboutMePage';
  static const String about_app = 'AboutAppPage';
  static const String register = 'register';

  static const String data_manage = 'DataManagePage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //
      case UnitRouter.nav:
        return NoAnimRouter(child: UnitNavigation());

      // 组件详情页
      case widget_detail:
        Widget child;
        if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
          child = DeskWidgetDetailPageScope(
            model: settings.arguments as WidgetModel,
          );
        } else {
          child = WidgetDetailPageScope(
            model: settings.arguments as WidgetModel,
          );
        }

        return Right2LeftRouter(child: child);

      case fancy_home:
        return Right2LeftRouter(child: const FancyHomePage());

      case standard_home:
        return Right2LeftRouter(
            child: StandardHomePage(
                family: settings.arguments as WidgetFamily,
            )
        );

      case gallery_unit:
        return Right2LeftRouter(child: const GalleryUnit());

      case user_page:
        return Right2LeftRouter(child: const UserPage());

      case search:
        return Right2LeftRouter(child: const SearchPageProvider());
      case collect:
        return Right2LeftRouter(child: const CollectPageAdapter());

      case setting:
        return Right2LeftRouter(child: const SettingPage());
      case data_manage:
        return Right2LeftRouter(child: const DataManagePage());
      case font_setting:
        return Right2LeftRouter(child: const FontSettingPage());
      case theme_color_setting:
        return Right2LeftRouter(child: const ThemeColorSettingPage());
      case code_style_setting:
        return Right2LeftRouter(child: const CodeStyleSettingPage());
      case item_style_setting:
        return Right2LeftRouter(child: const ItemStyleSettingPage());

      case version_info:
        return Right2LeftRouter(child: const VersionInfo());

      case issues_point:
        return Right2LeftRouter(child: const IssuesPointScope());
      case login:
        return Right2LeftRouter(child: const LoginPage());

      case register:
        return Right2LeftRouter(child: const RegisterPage());

      case attr:
        return Right2LeftRouter(child: const AttrUnitPage());
      case bug:
        return Right2LeftRouter(child: const BugUnitPage());
      case layout:
        return Right2LeftRouter(child: const LayoutUnitPage());
      case about_app:
        return Right2LeftRouter(child: const AboutAppPage());
      case about_me:
        return Right2LeftRouter(child: const AboutMePage());

      case point_detail:
        return Right2LeftRouter(child: const IssuesDetailPage());

      case category_show:
        return Right2LeftRouter(
            child: CategoryShow(
          model: settings.arguments as CategoryModel,
        ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
