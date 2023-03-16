import 'package:app_config/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:components/toly_ui/toly_ui.dart';
import 'package:widget_repository/widget_repository.dart';

class CollectWidgetListItem extends StatelessWidget {
  final WidgetModel data;
  final Function(WidgetModel model)? onDeleteItemClick;

  const CollectWidgetListItem({Key? key, required this.data, this.onDeleteItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Material(
          color: itemColor.withAlpha(66),
          shape: TechnoShapeBorder(color: itemColor),
          child:  Row(
              children: <Widget>[
                _buildLeading(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTitle(),
                      _buildSummary(),
                      StarScore(
                        star: Star(
                            emptyColor: Colors.white,
                            size: 12,
                            fillColor: itemColor),
                        score: data.lever,
                      )
                    ],
                  ),
                ),
              ],
          ),
        ),
        Positioned(
            bottom: 5,
            right: 5,
            child: FeedbackWidget(
              onPressed: () {
                onDeleteItemClick?.call(data);
              },
              child: const Icon(
                CupertinoIcons.delete_solid,
                color: Colors.red,
              ),
            ))
      ],
    );
  }

  Widget _buildLeading() => Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: data.image == null
            ? Material(
                color: Colors.transparent,
                child: CircleText(
                  text: data.name,
                  size: 50,
                  color: itemColor,
                ),
              )
            : CircleImage(
                image: data.image!,
                size: 50,
              ),
      );

  Color get itemColor => Cons.tabColors[data.family.index];

  Widget _buildTitle() => Row(
      children: <Widget>[
        Expanded(
          child: Text(data.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        color: Colors.white, offset: Offset(.3, .3))
                  ])),
        ),
      ],
    );

  Widget _buildSummary() => Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
      child: Text(
        data.nameCN,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            shadows: const [Shadow(color: Colors.white, offset: Offset(.5, .5))]),
      ),
    );
}
