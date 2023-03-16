import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:widget_repository/widget_repository.dart';

/// create by 张风捷特烈 on 2020-04-21
/// contact me by email 1981462002@qq.com
/// 说明: 

class CategoryListItem extends StatelessWidget {
  final CategoryModel data;
  final Function(CategoryModel)? onDeleteItemClick;
  final Function(CategoryModel)? onEditItemClick;

  const CategoryListItem({Key? key, required this.data, this.onDeleteItemClick,this.onEditItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildChild(context),
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1),blurRadius: 2)
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );

  }

  _buildChild(BuildContext context) {
    final Color themeColor = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        _buildTitle(themeColor),
        const Divider(),
        Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(data.info,
                      style: TextStyle(
                          color: Colors.grey,
                          shadows: [
                            Shadow(color: themeColor.withOpacity(0.4), offset:const Offset(.2,.2),blurRadius: .5)
                          ])),
                ),
                  Positioned(
                      bottom: 5,
                      right: 5,
                      child:
                      FeedbackWidget(
                        onPressed: () {
                          onEditItemClick?.call(data);
                        },
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: themeColor,
                        ),
                      )
                  )
              ],
            )),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            '创建于 ${data.createDate}',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Row _buildTitle(Color themeColor) {
    return Row(
      children: <Widget>[
        CircleText(
          text: "${data.count}",
          size: 35,
          fontSize: 14,
          backgroundColor: data.color,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Text(
              data.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
          FeedbackWidget(
            onPressed: () {
              onDeleteItemClick?.call(data);
            },
            child: const Icon(
              CupertinoIcons.delete_solid,
              color: Colors.red,
            ),
          )
      ],
    );
  }
}