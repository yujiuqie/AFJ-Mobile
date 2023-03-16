import 'package:widget_repository/src/model/model.dart';
import 'package:widget_repository/src/widget_repository.dart';
import 'package:db_storage/db_storage.dart';


/// create by 张风捷特烈 on 2020-03-03
/// contact me by email 1981462002@qq.com
/// 说明 : Widget数据仓库

class WidgetDbRepository implements WidgetRepository {

  const WidgetDbRepository();

  WidgetDao get widgetDao => LocalDb.instance.widgetDao;
  LikeDao get likeDao => LocalDb.instance.likeDao;

  @override
  Future<List<WidgetModel>> loadLikeWidgets() async {
    List<int> likeIds = await likeDao.likeWidgetIds();
    List<Map<String, dynamic>> data = await widgetDao.queryByIds(likeIds);
    List<WidgetPo> widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> searchWidgets(WidgetFilter args) async {
    List<Map<String, dynamic>> data = await widgetDao.search(args);
    List<WidgetPo> widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    return widgets.map(WidgetModel.fromPo).toList();
  }

  @override
  Future<List<WidgetModel>> loadWidget(List<int> id) async {
    List<Map<String, dynamic>> data = await widgetDao.queryByIds(id);
    List<WidgetPo> widgets = data.map((e) => WidgetPo.fromJson(e)).toList();
    if (widgets.isNotEmpty) return widgets.map(WidgetModel.fromPo).toList();
    return [];
  }

  @override
  Future<void> toggleLike(
    int id,
  ) {
    return likeDao.toggleCollect(id);
  }

  @override
  Future<int> collected(int id) async {
    return await likeDao.like(id);
  }
}
