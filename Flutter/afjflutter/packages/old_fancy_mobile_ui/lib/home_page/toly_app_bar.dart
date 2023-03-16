import 'package:flutter/material.dart';


class TolyAppBar extends StatefulWidget {
  final double maxHeight;
  final Function(int)? onItemClick;
  final int defaultIndex;

  const TolyAppBar({Key? key, required this.maxHeight, this.onItemClick, this.defaultIndex = 0}) : super(key: key);

  @override
  _TolyAppBarState createState() => _TolyAppBarState();

}

const BorderRadius _kBorderRadius = BorderRadius.only(
  bottomLeft: Radius.circular(15),
  bottomRight: Radius.circular(15),
);

const TextStyle _kTabTextStyle = TextStyle(color: Colors.white, shadows: [
  Shadow(color: Colors.black, offset: Offset(0.5, 0.5), blurRadius: 0.5)
]);

class _TolyAppBarState extends State<TolyAppBar>
    with SingleTickerProviderStateMixin {
  // double? _width;
  int _selectIndex = 0;
  int _prevSelectIndex = 0;

  static const List<int> colors = [
    0xff44D1FD,
    0xffFD4F43,
    0xffB375FF,
    0xFF4CAF50,
    0xFFFF9800,
    0xFF00F1F1,
    0xFFDBD83F
  ];

  static const List<String> info = [
    'Stles',
    'Stful',
    'Scrow',
    'Mcrow',
    'Sliver',
    'Proxy',
    'Other'
  ];

  static const List<String> semantics = [
    '无状态组件',
    '有状态组件',
    '单子组件',
    '多子组件',
    '滑动组件',
    '代理组件',
    '其他组件'
  ];

  late AnimationController _controller;
  late Animation<double> circleAnim;
  late Animation<double> heightAnim;
  late Animation<double> backCircleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 1,
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    circleAnim = circleTween.animate(_controller);
    heightAnim = CurveTween(curve: Curves.ease).animate(_controller);
    backCircleAnim = ReverseAnimation(circleAnim);

    _selectIndex = widget.defaultIndex;
  }

  int get nextIndex => (_selectIndex + 1) % colors.length;

  Tween<double> circleTween = Tween(begin: 1, end: 0);

  @override
  Widget build(BuildContext context) {
    // _width = MediaQuery.of(context).size.width / colors.length;
    return LayoutBuilder(
      builder:(_,c)=> Center(
        child:Flow(
            delegate: TolyAppBarDelegate(
              _selectIndex,
              _prevSelectIndex,
              widget.maxHeight,
              repaint: heightAnim,
            ),
            children: [
              ...colors
                  .map((e) => GestureDetector(
                        onTap: () => _onTap(e),
                        child: _buildChild(e,c.maxWidth/ colors.length),
                      ))
                  .toList(),
              ...colors.map((e) {
                Widget child = CircleAvatar(
                  backgroundColor: Color(e),
                  radius: 6,
                );
                if (e == colors[_selectIndex]) {
                  return ScaleTransition(scale: circleAnim, child: child);
                }
                if (e == colors[_prevSelectIndex]) {
                  return ScaleTransition(scale: backCircleAnim, child: child);
                }
                return child;
              })
            ]),
      ),
    );
  }

  Widget _buildChild(int color,double width) {
    ThemeData themeData = Theme.of(context);
    bool isDark = themeData.brightness == Brightness.dark;
    int index = colors.indexOf(color);
    return Container(
    alignment: const Alignment(0, 0.4),
    decoration: BoxDecoration(boxShadow: [
      if(!isDark)
      BoxShadow(
          color: _selectIndex == colors.indexOf(color)
              ? Colors.transparent
              : Color(colors[_selectIndex]),
          offset: const Offset(1, 1),
          blurRadius: 2)
    ], color: Color(color), borderRadius: _kBorderRadius),
    height: widget.maxHeight + 20,
    width: width,
    child: Text(
      info[index],
      style: _kTabTextStyle,
      semanticsLabel: '您当前点击了:${semantics[index]}',
    ),
  );
  }

  void _onTap(int color) {
    if (_selectIndex == colors.indexOf(color)) return;
    setState(() {
      _controller.reset();
      _controller.forward();
      _prevSelectIndex = _selectIndex;
      _selectIndex = colors.indexOf(color);
      widget.onItemClick?.call(_selectIndex);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TolyAppBarDelegate extends FlowDelegate {
  final int selectIndex;
  final int prevSelectIndex;
  final double height;
  final Animation<double> repaint;

  TolyAppBarDelegate(this.selectIndex, this.prevSelectIndex, this.height,
      {required this.repaint})
      : super(repaint: repaint);

  double get factor => repaint.value;

  @override
  void paintChildren(FlowPaintingContext context) {
    double ox = 0;
    double obx = 0;

    for (int i = 0; i < context.childCount / 2; i++) {
      Size cSize = context.getChildSize(i)??Size.zero;
      if (i == selectIndex) {
        context.paintChild(i,
            transform: Matrix4.translationValues(ox, 20.0 * factor - 20, 0.0));
        ox += cSize.width;
      } else if (i == prevSelectIndex) {
        context.paintChild(i,
            transform:
                Matrix4.translationValues(ox, 20.0 * (1 - factor) - 20, 0.0));
        ox += cSize.width;
      } else {
        context.paintChild(i,
            transform: Matrix4.translationValues(ox, -20, 0.0));
        ox += cSize.width;
      }
    }

    // 绘制小点
    for (int i = (context.childCount / 2).floor(); i < context.childCount; i++) {
      Size size = context.getChildSize(0)??Size.zero;
      context.paintChild(i,
          transform: Matrix4.translationValues(
              obx + size.width / 2 - 5, height + 5, 0));
      obx += size.width;
    }
  }

  @override
  bool shouldRepaint(TolyAppBarDelegate oldDelegate) =>
      oldDelegate.selectIndex != selectIndex ||
      oldDelegate.height != height ||
      oldDelegate.repaint != repaint;
}
