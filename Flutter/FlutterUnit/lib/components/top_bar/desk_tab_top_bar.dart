import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/plateform_adapter/window/windows_adapter.dart';

import '../../widget_ui/desk_ui/widget_panel/window_buttons.dart';


class DeskTabTopBar extends StatefulWidget {
  final List<String> tabs;
  final ValueChanged<int> onTabPressed;


  const DeskTabTopBar({Key? key,required this.onTabPressed, required this.tabs}) : super(key: key);

  @override
  State<DeskTabTopBar> createState() => _DeskTabTopBarState();
}

class _DeskTabTopBarState extends State<DeskTabTopBar>  with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void didUpdateWidget(covariant DeskTabTopBar oldWidget) {
    if(oldWidget.tabs.length!=widget.tabs.length){
      tabController.dispose();
      tabController = TabController(length: widget.tabs.length, vsync: this);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;

    return DragToMoveAreaNoDouble(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 64,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 350,
              child: TabBar(
                onTap: widget.onTabPressed,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                isScrollable: false,
                indicator: RoundRectTabIndicator(
                  borderSide: BorderSide(color: themeColor, width: 3),
                ),
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                controller: tabController,
                labelColor: themeColor,
                indicatorWeight: 3,
                unselectedLabelColor: Colors.grey,
                indicatorColor: themeColor,
                tabs: widget.tabs.map((String name) => Tab(text: name)).toList(),
              ),
            ),
            Spacer(),
            const SizedBox(width: 20,),
            WindowButtons(),
          ],
        ),
      ),
    );
  }
}
