import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/widget_ui/mobile/widget_detail/category_end_drawer.dart';
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
        ..push(model),
      child: DeskWidgetDetailPage(
        model: model,
      ),
    );
  }
}

class DeskWidgetDetailPage extends StatelessWidget {
  final WidgetModel model;

  const DeskWidgetDetailPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetDetailBloc bloc = context.watch<WidgetDetailBloc>();

    return BlocBuilder<WidgetDetailBloc, DetailState>(
      builder: (_, state) => Scaffold(
        endDrawer: CategoryEndDrawer(widget: bloc.currentWidget),
        body: Builder(builder: (ctx) {
          return _buildContent(ctx, bloc);
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

  Widget _buildContent(BuildContext context, WidgetDetailBloc bloc) {
    DetailState state = bloc.state;
    return WillPopScope(
        onWillPop: () => _whenPop(context),
        child: CustomScrollView(
          slivers: [
            DeskSliverWidgetDetailBar(model: bloc.currentWidget),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DeskWidgetDetailPanel(model: bloc.currentWidget),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          linkText,
                          if (state is DetailWithData)
                            LinkWidgetButtons(
                              links: state.links,
                              onSelect: bloc.push,
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
              _buildSliverNodeList(context, state.nodes, state.widgetModel)
          ],
        ));
  }

  Future<bool> _whenPop(BuildContext context) async {
    WidgetDetailBloc detailBloc = context.read<WidgetDetailBloc>();
    if (Scaffold.of(context).isEndDrawerOpen) {
      return true;
    }
    return detailBloc.pop();
  }

  Widget _buildSliverNodeList(
      BuildContext context, List<NodeModel> nodes, WidgetModel model) {
    AppState globalState = BlocProvider.of<AppBloc>(context).state;
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (_, i) => DeskWidgetNodePanel(
        codeStyle: globalState.codeStyle,
        codeFamily: 'Inconsolata',
        text: nodes[i].name,
        subText: nodes[i].subtitle,
        code: nodes[i].code,
        death: model.death,
        show: WidgetsMap.map(model.name)[i],
      ),
      childCount: nodes.length,
    ));
  }
}
