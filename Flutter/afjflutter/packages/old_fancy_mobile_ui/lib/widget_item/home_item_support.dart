import 'dart:math';

import 'package:app_config/app_config.dart';
import 'package:db_storage/db_storage.dart';
import 'package:flutter/material.dart';
import 'package:widget_repository/widget_repository.dart';

import 'coupon_widget_list_item.dart';
import 'simple_widget_list_item.dart';
import 'techno_widget_list_item.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明:

class HomeItemSupport {

  static Map<int,ShapeBorder> shapeBorderMap={
    1: TechnoShapeBorder(),
    2: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    3: const CouponShapeBorder(
        hasTopHole: true,
        hasBottomHole: false,
        hasLine: false,
        edgeRadius: 25,
        lineRate: 0.20),
    4: const CouponShapeBorder(
        hasTopHole: false,
        hasBottomHole: false,
        hasLine: false,
        edgeRadius: 25,
        lineRate: 0.20),
    5: const CouponShapeBorder(
        hasTopHole: true,
        hasBottomHole: false,
        hasLine: false,
        edgeRadius: 25,
        lineRate: 0.20),
  };

  static Widget get(
    WidgetModel model,
    int index,
  ) {
    switch (index) {
      case 1:
        return TechnoWidgetListItem(data: model);
      case 2:
        return SimpleWidgetListItem(data: model);
      case 3:
        return CouponWidgetListItem(data: model);
      case 4:
        return CouponWidgetListItem(hasTopHole: false, data: model);
      case 5:
        return CouponWidgetListItem(
            hasTopHole: true, hasBottomHole: true, data: model);
      case 6:
        return CouponWidgetListItem(isClip: false, data: model);
    }
    return TechnoWidgetListItem(data: model);
  }

  static List<Widget> itemSimples() => [
        Container(
          height: 10,
        ),
        TechnoWidgetListItem(data: getContainer()),
        SimpleWidgetListItem(data: getContainer()),
        CouponWidgetListItem(data: getContainer()),
        CouponWidgetListItem(hasTopHole: false, data: getContainer()),
        CouponWidgetListItem(
            hasTopHole: true, hasBottomHole: true, data: getContainer()),
        CouponWidgetListItem(isClip: false, data: getContainer()),
      ];

  static WidgetModel getContainer() => WidgetModel(
      id: Random().nextInt(10000),
      name: 'Container',
      nameCN: "",
      links: const [],
      lever: 5,
      family: WidgetFamily.statelessWidget,
      info: '用于容纳单个子组件的容器组件。集成了若干个单子组件的功能，如内外边距、形变、装饰、约束等...');
}
