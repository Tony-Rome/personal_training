import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
class SqlHelper {

  static Future<void> createTables(Database database) async {
    await database.execute("""
      CREATE TABLE IF NOT EXISTS exercise(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        mode TEXT,
        description TEXT
      )
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS exercise_detail(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        sets INTEGER NOT NULL,
        reps INTEGER NOT NULL,
        lift INTEGER NOT NULL,
        sets_rest TEXT NOT NULL,
        reps_rest TEXT NOT NULL,
        exercise_id INTEGER,
        FOREIGN KEY(exercise_id) REFERENCES exercise(id)
      )
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS routine(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT NOT NULL
      )
    """);

    await database.execute("""
      CREATE TABLE IF NOT EXISTS exercise_detail_routine(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        exercise_detail_id INTEGER,
        routine_id INTEGER,
        FOREIGN KEY(exercise_detail_id) REFERENCES exercise_detail(id),
        FOREIGN KEY(routine_id) REFERENCES routine(id)
      )
    """);
  }

  static Future<Database> db() async {
    return openDatabase(
        'db_routine.db',
      version: 4,
      onCreate: (Database database, int version) async {
          print("--->Creando otra version de DB local <---");
          await createTables(database);
      },
      onUpgrade: (Database database, int version, int _) async {
        print("--->Actualizando a version $version de DB local <---");
        await createTables(database);
      }
    );
  }

  static Future<int> createExercise(String name, String mode, String description) async {
    final db = await SqlHelper.db();

    final data = {'name': name, 'mode': mode, 'description': description};
    final id = await db.insert(
        'exercise',
        data,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getExercises() async {
    final db = await SqlHelper.db();
    return db.query('exercise', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getExercise(int id) async {
    final db = await SqlHelper.db();
    return db.query('exercise', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateExercise(int id, String name) async {
    final db = await SqlHelper.db();
    final data = {
      'name': name
    };

    final result = await db.update('exercise', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteExercise(int id) async {
    final db = await SqlHelper.db();
    try {
      await db.delete('exercise', where: "id = ?", whereArgs: [id]);
    } catch (err) {
        debugPrint("Hubo un error! : $err");
    }
  }



  static Future<int> createExerciseDetailRoutine(int exerciseDetailId, int routineId) async {
    final db = await SqlHelper.db();

    final data = {'exercise_detail_id': exerciseDetailId, 'routine_id': routineId};
    final id = await db.insert(
        'exercise_detail_routine',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllExerciseDetailRoutine() async {
    final db = await SqlHelper.db();
    return db.query('exercise_detail_routine', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getExerciseDetailRoutine(int id) async {
    final db = await SqlHelper.db();
    return db.query('exercise_detail_routine', where: "id = ?", whereArgs: [id], limit: 1);
  }



}