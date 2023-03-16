import 'package:app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:widget_repository/widget_repository.dart';

class LinkWidgetButtons extends StatelessWidget {
  final List<WidgetModel> links;
  final ValueChanged<WidgetModel> onSelect;

  const LinkWidgetButtons(
      {Key? key, required this.links, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color chipColor = Theme.of(context).primaryColor;

    if (links.isEmpty) {
      return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Chip(
            backgroundColor: Colors.grey.withAlpha(120),
            labelStyle: const TextStyle(fontSize: 12, color: Colors.white),
            label: const Text('暂无链接组件'),
          ));
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10),
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: links
            .map((WidgetModel model) => ActionChip(
                  labelPadding: EdgeInsets.zero,
                  side: BorderSide.none,
                  onPressed: () => onSelect(model),
                  elevation: 1,
                  // shadowColor: chipColor,
                  backgroundColor: chipColor,
                  labelStyle: model.deprecated
                      ? UnitTextStyle.deprecatedChip
                      : UnitTextStyle.commonChip,
                  label: Text(model.name),
                ))
            .toList(),
      ),
    );
  }
}
