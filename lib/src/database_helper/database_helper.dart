import 'dart:convert';
import 'dart:io';
import 'package:capital/src/models/world/world.dart';
import 'package:capital/src/utils/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _db;

  DatabaseHelper._instance();

  final String tableName = "capital";

  final String colId = 'id';
  final String colCapital = 'capital';
  final String colCountry = 'country';

  Future<Database?> get db async {
    return _db ?? await _initDB();
  }

  // salom.mp3
  // todo.db

  Future<Database?> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "capital.db";
    _db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      db.execute("CREATE TABLE $tableName ("
          "$colId INTEGER PRIMARY KEY,"
          "$colCapital TEXT,"
          "$colCountry TEXT"
          ")");
    });
    return _db;
  }

  Future<void> loadDB(context) async {
    print("DATABASE LOADED");
    String data =
    await DefaultAssetBundle.of(context).loadString("assets/capital/capitals.json");
    final jsonResult = jsonDecode(data);

    List<World> capitals = jsonResult.map<World>((data) {
      return World.fromJson(data);
    }).toList();

    for (var word in capitals) {
      await insert(word);
    }
    capitals.forEach((element) {print(element.country);});

    saveState();
  }

  Future<void> saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.IS_DATABASE_INIT, true);
  }

  Future<World> insert(World world) async {
    final data = await db;
    world.id = await data?.insert(tableName, world.toMap());
    return world;
  }

  Future<List<Map<String, Object?>>?> getWorldMap(
      {String? word, bool? isCity}) async {
    final data = await db;
    final List<Map<String, Object?>>? result;
    if (word == null) {
      result = await data?.query(tableName);
    } else {
      result = await data?.query(
        tableName,
        where: isCity! ? '$colCapital LIKE ?' : '$colCountry LIKE ?',
        whereArgs: ["$word%"],
      );
    }
    return result;
  }

  Future<List<World>> getWorld() async {
    final List<Map<String, Object?>>? worldMap = await getWorldMap();
    final List<World> world = [];
    worldMap?.forEach((element) {
      world.add(World.fromMap(element));
    });
    return world;
  }

  Future<int?> update(World world) async {
    final data = await db;
    return await data?.update(tableName, world.toMap(),
        where: '$colId = ?', whereArgs: [world.id]);
  }
  Future<int?> delete(int worldId) async{
    final data = await db;
    return await data?.delete(
      tableName, where: "$colId = ?", whereArgs: [worldId]);

  }
  Future<List<World>> getWorldLike(String word, bool isCity) async {
    final List<Map<String, Object?>>? wordMap =
    await getWorldMap(word: word, isCity: isCity);
    final List<World> words = [];
    wordMap?.forEach((element) {
      words.add(World.fromMap(element));
    });
    return words;
  }
}
