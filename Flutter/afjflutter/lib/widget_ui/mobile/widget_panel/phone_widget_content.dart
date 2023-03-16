import 'package:app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:old_fancy_mobile_ui/old_fancy_mobile_ui.dart';
import 'package:widget_repository/widget_repository.dart';

import 'widget_model_item.dart';

class PhoneWidgetContent extends StatelessWidget {
  final List<WidgetModel> items;

  const PhoneWidgetContent({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: _cellForRow
        );
  }

  Widget _cellForRow(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(items[index].nameCN),
        subtitle: Text(items[index].info),
        onTap: () {
          Navigator.pushNamed(
            context,
            UnitRouter.widget_detail,
            arguments: items[index],
          );
        },
      ),
    );
  }
}
