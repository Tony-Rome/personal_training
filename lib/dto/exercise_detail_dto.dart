import 'package:personal_training/dto/exercise_dto.dart';

class ExerciseDetailDTO extends ExerciseDTO{
  int? sets;
  int? reps;
  int? lift;
  String? setsRest;
  String? repsRest;

  @override
  toString(){
    return '{'
        'name: $name,'
        ' mode: $mode,'
        ' description: $description,'
        ' sets: $sets,'
        ' reps: $reps,'
        ' lift: $lift,'
        ' sets_rest: $setsRest,'
        ' reps_rest: $repsRest'
        '}';
  }
}