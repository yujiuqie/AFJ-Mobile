/// create by 张风捷特烈 on 2020-03-07
/// contact me by email 1981462002@qq.com
/// 说明:

enum WidgetFamily {
  statelessWidget,
  statefulWidget,
  singleChildRenderObjectWidget,
  multiChildRenderObjectWidget,
  sliver,
  proxyWidget,
  other,
}

// '无态', '有态', '单渲', '多渲', '滑片', '代理', '其它'

extension WidgetFamilyExtension on WidgetFamily {
  String get displayTitle {
    switch (this) {
      case WidgetFamily.statelessWidget:
        return '无状态组件';
      case WidgetFamily.statefulWidget:
        return '有态组件';
      case WidgetFamily.singleChildRenderObjectWidget:
        return '单渲组件';
      case WidgetFamily.multiChildRenderObjectWidget:
        return '多渲组件';
      case WidgetFamily.sliver:
        return '滑片类组件';
      case WidgetFamily.proxyWidget:
        return '代理类组件';
      case WidgetFamily.other:
        return '其它组件';
      default:
        return 'Title is null';
    }
  }
}