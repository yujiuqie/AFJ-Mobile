import 'package:afjflutter/widget_ui/mobile/widget_panel/phone_widget_content.dart';
import 'package:app_config/app_config.dart';
import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afjflutter/app/navigation/home_drawer.dart';
import 'package:afjflutter/app/utils/convert.dart';
import 'package:old_fancy_mobile_ui/bloc/color_change_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_repository/widget_repository.dart';

import 'standard_home_search.dart';
import 'widget_list_panel.dart';

class StandardHomePage extends StatefulWidget {
  final WidgetFamily family;
  const StandardHomePage({Key? key,required this.family}) : super(key: key);

  @override
  State<StandardHomePage> createState() => _StandardHomePageState();
}

class _StandardHomePageState extends State<StandardHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  // static const List<String> _tabs = ['无态', '有态', '单渲', '多渲', '滑片', '代理', '其它'];
  final WidgetRepository repository = const WidgetDbRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.family.displayTitle),
        actions: [],
      ),
      body: Center(child: buildScrollPage()),
    );
  }

  Widget buildScrollPage() {
    print("buildScrollPage == ${widget.family.displayTitle}");
    return FutureBuilder(
      future: getList(widget.family),
      builder: (context, AsyncSnapshot<List<WidgetModel>> snapshot) {
        var widget;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            widget = Text("出错了");
          } else {
            final List<WidgetModel> widgets =
                snapshot.data as List<WidgetModel>;
            widget = PhoneWidgetContent(
              items: widgets,
            );
          }
        } else {
          widget = Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          );
        }

        return Center(
          child: widget,
        );
      },
    );
  }

  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) {
          return ListTile(
            leading: Text("Item $index"),
          );
        },
        childCount: count,
      ),
      itemExtent: 50,
    );
  }

  Future<List<WidgetModel>> getList(WidgetFamily family) async {
    final List<WidgetModel> widgets =
        await repository.searchWidgets(WidgetFilter.family(family));
    return widgets;
  }

  @override
  bool get wantKeepAlive => true;
}
