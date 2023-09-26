import 'package:personal_training/helper/sql_helper.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseDetailHelper {
  static Future<int> createExerciseDetail(int sets , int reps, int lift, String setsRest, String repsRest, int exerciseId) async {
    final db = await SqlHelper.db();

    final data = {'sets': sets, 'reps': reps, 'lift': lift, 'sets_rest': setsRest, 'reps_rest': repsRest, 'exercise_id': exerciseId};
    final id = await db.insert(
        'exercise_detail',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllExerciseDetail() async {
    final db = await SqlHelper.db();
    return db.query('exercise_detail', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getExerciseDetail(int id) async {
    final db = await SqlHelper.db();
    return db.query('exercise_detail', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<void> deleteExerciseDetail(int id) async {
    final db = await SqlHelper.db();

    // Elimina el detalle ejercicio rutina
    await db.delete('exercise_detail_routine', where: "exercise_detail_id = ?", whereArgs: [id]);

    // Elimina el detalle ejercicio
    await db.delete('exercise_detail', where: "id = ?", whereArgs: [id]);
  }

  static Future<void> updateExerciseDetail(Map<String, dynamic> values) async {
    final db = await SqlHelper.db();
    await db.update('exercise_detail', values, where: 'id = ?', whereArgs: [values['id']]);
  }
}