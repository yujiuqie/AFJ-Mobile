import 'dart:io';

import 'package:db_storage/db_storage.dart';

import 'db_open_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';


class LocalDb {
  Database? _database;

  LocalDb._();

  static LocalDb instance = LocalDb._();

  late WidgetDao _widgetDao;
  late CategoryDao _categoryDao;
  late NodeDao _nodeDao;
  late LikeDao _likeDao;

  WidgetDao get widgetDao => _widgetDao;

  CategoryDao get categoryDao => _categoryDao;

  NodeDao get nodeDao => _nodeDao;

  LikeDao get likeDao => _likeDao;

  Database get db => _database!;
  bool get inited => _database!=null;

  Future<void> initDb({String name = "flutter.db"}) async {
    if (_database != null) return;
    String databasesPath = await DbOpenHelper.getDbDirPath();
    String dbPath = path.join(databasesPath, name);

    if (Platform.isWindows||Platform.isLinux) {
      DatabaseFactory databaseFactory = databaseFactoryFfi;
      _database = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
            // version: DbUpdater.VERSION,
            // onCreate: _onCreate,
            // onUpgrade: _onUpgrade,
            // onOpen: _onOpen
        ),
      );
    }else{
      _database = await openDatabase(dbPath);
    }

    _widgetDao = WidgetDao(_database!);
    _categoryDao = CategoryDao(_database!);
    _nodeDao = NodeDao(_database!);
    _likeDao = LikeDao(_database!);

    print('初始化数据库....');
  }

  Future<void> closeDb() async {
    await _database?.close();
    _database = null;
  }
}
