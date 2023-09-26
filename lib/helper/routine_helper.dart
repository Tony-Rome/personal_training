import 'package:personal_training/helper/sql_helper.dart';
import 'package:sqflite/sqflite.dart';

class RoutineHelper{

  static Future<List<Map<String,dynamic>>> getCompleteRoutineByRoutineId(int routineId) async{
    final db = await SqlHelper.db();
    return await db.rawQuery('SELECT '
        'e.name, '
        'e.mode, '
        'e.description, '
        'ed.id, '
        'ed.sets, '
        'ed.reps, '
        'ed.lift, '
        'ed.sets_rest, '
        'ed.reps_rest '
        'FROM exercise e '
        'join exercise_detail ed '
        'on e.id = ed.exercise_id '
        'join exercise_detail_routine edr '
        'on ed.id = edr.exercise_detail_id '
        'join routine r '
        'on edr.routine_id = r.id '
        'WHERE r.id = $routineId');
  }

  static Future<int> createRoutine(String name) async {
    final db = await SqlHelper.db();

    final data = {'name': name};
    final id = await db.insert(
        'routine',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getRoutines() async {
    final db = await SqlHelper.db();
    return db.query('routine', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getRoutine(int id) async {
    final db = await SqlHelper.db();
    return db.query('routine', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<void> deleteRoutine(int id) async {
    // TODO: Borra solo de la tabla rutina
    final db = await SqlHelper.db();
    await db.delete('routine', where: "id = ?", whereArgs: [id]);
  }

  // TODO: Agregar funcion para borrar rutina, rutina ejercicio detalle y ejercicio detalle
}