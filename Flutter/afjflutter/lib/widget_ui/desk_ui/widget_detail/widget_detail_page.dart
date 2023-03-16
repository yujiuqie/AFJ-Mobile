import 'package:app_config/app_config.dart';
import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afjflutter/widget_ui/mobile/widget_detail/category_end_drawer.dart';
import 'package:widget_module/blocs/blocs.dart';

import 'package:widget_repository/widget_repository.dart';
import 'package:widgets/widgets.dart';

import 'link_widget_buttons.dart';
import 'widget_detail_bar.dart';
import 'widget_detail_panel.dart';
import 'widget_node_panel.dart';

// 用于组件详情不需要在一开始就加载
// WidgetDetailBloc 可以在稍后提供
class DeskWidgetDetailPageScope extends StatelessWidget {
  final WidgetModel model;

  const DeskWidgetDetailPageScope({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WidgetDetailBloc>(
      create: (_) => WidgetDetailBloc(
          widgetRepository: const WidgetDbRepository(),
          nodeRepository: const NodeDbRepository())
        ..add(FetchWidgetDetail(model)),
      child: DeskWidgetDetailPage(
        model: model,
      ),
    );
  }
}

class DeskWidgetDetailPage extends StatefulWidget {
  final WidgetModel model;

  const DeskWidgetDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  _DeskWidgetDetailPageState createState() => _DeskWidgetDetailPageState();
}

class _DeskWidgetDetailPageState extends State<DeskWidgetDetailPage> {
  final List<WidgetModel> _modelStack = [];

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    _modelStack.add(widget.model);
    super.initState();
  }

  // 获取当前的 组件数据模型
  WidgetModel get currentWidgetModel => _modelStack.last;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetDetailBloc, DetailState>(
      builder: (_, state) => Scaffold(
        endDrawer: CategoryEndDrawer(widget: currentWidgetModel),
        body: Builder(builder: (ctx) {
          return _buildContent(ctx, state);
        }),
      ),
    );
  }

  Widget get linkText => Row(
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 5),
            child: Icon(Icons.link, color: Colors.blue),
          ),
          Text('相关组件', style: UnitTextStyle.labelBold),
        ],
      );

  Widget _buildContent(BuildContext context, DetailState state) {
    return WillPopScope(
        onWillPop: () => _whenPop(context),
        child: CustomScrollView(
          slivers: [
            DeskSliverWidgetDetailBar(model: _modelStack.last),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DeskWidgetDetailPanel(model: _modelStack.last),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          linkText,
                          if (state is DetailWithData)
                            LinkWidgetButtons(
                              links: state.links,
                              onSelect: _toLinkWidget,
                            )
                        ],
                      ))
                    ],
                  ),
                  const Divider()
                ],
              ),
            ),
            if (state is DetailWithData)
              _buildSliverNodeList(state.nodes, state.widgetModel.name)
          ],
        ));
  }

  Future<bool> _whenPop(BuildContext context) async {
    if (Scaffold.of(context).isEndDrawerOpen || _modelStack.isEmpty) {
      return true;
    }
    _modelStack.removeLast();
    if (_modelStack.isNotEmpty) {
      BlocProvider.of<WidgetDetailBloc>(context).add(
        FetchWidgetDetail(currentWidgetModel),
      );
      return false;
    } else {
      return true;
    }
  }

  void _toLinkWidget(WidgetModel model) {
    BlocProvider.of<WidgetDetailBloc>(context).add(FetchWidgetDetail(model));
    _modelStack.add(model);
  }

  Widget _buildSliverNodeList(List<NodeModel> nodes, String name) {
    AppState globalState = BlocProvider.of<AppBloc>(context).state;
    HighlighterStyle codeStyle =
        Cons.codeThemeSupport.keys.toList()[globalState.codeStyleIndex];
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (_, i) => DeskWidgetNodePanel(
        codeStyle: codeStyle,
        codeFamily: 'Inconsolata',
        text: nodes[i].name,
        subText: nodes[i].subtitle,
        code: nodes[i].code,
        death: _modelStack.last.death,
        show: WidgetsMap.map(name)[i],
      ),
      childCount: nodes.length,
    ));
  }
}
