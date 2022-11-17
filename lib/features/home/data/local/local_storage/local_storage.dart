import 'package:explore/features/home/data/local/models/favorite_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalStorage {
  Future<Database> initializeDatabase();
  Future<void> insertMovie(FavoriteModel model);
  Future<List<FavoriteModel>> fetchFavoriteMovies();
  Future<void> deleteMovie(String movieId);
  Future<bool> checkIfMovieExists(String movieId);
}

class LocalStorageImpl implements LocalStorage {
  static const _databaseName = "Favorite.db";
  static const _databaseVersion = 1;

  static const table = 'Favorite';

  static const columnId = 'movieId';
  static const columnImage = 'imageUrl';
  static const columnRating = 'averageRating';
  static const columnYear = 'year';
  static const columnMovieName = 'movieName';

  @override
  Future<Database> initializeDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $table ($columnId TEXT PRIMARY KEY, $columnImage TEXT, $columnRating TEXT, $columnYear TEXT, $columnMovieName TEXT)',
        );
      },
      version: _databaseVersion,
    );
  }

  @override
  Future<void> insertMovie(FavoriteModel model) async {
    final database = await initializeDatabase();
    await database.insert(
      table,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<FavoriteModel>> fetchFavoriteMovies() async {
    final database = await initializeDatabase();

    final List<Map<String, dynamic>> maps = await database.query(table);
    return List.generate(maps.length, (index) {
      return FavoriteModel(
        averageRating: maps[index][columnRating],
        imageUrl: maps[index][columnImage],
        movieId: maps[index][columnId],
        year: maps[index][columnYear],
        movieName: maps[index][columnMovieName],
      );
    });
  }

  @override
  Future<void> deleteMovie(String movieId) async {
    final database = await initializeDatabase();
    try {
      await database
          .delete(table, where: "$columnId = $movieId", whereArgs: [columnId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  @override
  Future<bool> checkIfMovieExists(String movieId) async {
    final database = await initializeDatabase();
    var result = await database.rawQuery(
      'SELECT EXISTS(SELECT 1 FROM $table WHERE $columnId=$movieId)',
    );
    int? exists = Sqflite.firstIntValue(result);
    return exists == 1;
  }
}
