import 'package:personal_training/dto/complete_exercise_dto.dart';
import 'package:personal_training/dto/exercise_dto.dart';

class ExerciseMapper {

  ExerciseDTO exerciseModelToExerciseDtoMapper(Map<String, dynamic> exerciseModel){
    ExerciseDTO exerciseDTO = ExerciseDTO();
    exerciseDTO
      ..id = exerciseModel['id']
      ..name = exerciseModel['name']
      ..mode = exerciseModel['mode']
      ..description = exerciseModel['description'];
    return exerciseDTO;
  }

  static CompleteExerciseDTO exerciseAndExerciseDetailModelToCompleteExercise(Map<String, dynamic> exerciseAndDetail){
    CompleteExerciseDTO completeExerciseDTO = CompleteExerciseDTO();
    return completeExerciseDTO
      ..id = exerciseAndDetail["id"]
      ..name = exerciseAndDetail["name"]
      ..mode = exerciseAndDetail["mode"]
      ..description = exerciseAndDetail["description"]
      ..sets = exerciseAndDetail["sets"]
      ..reps = exerciseAndDetail["reps"]
      ..lift = exerciseAndDetail["lift"]
      ..setsRest = exerciseAndDetail["setsRest"]
      ..repsRest = exerciseAndDetail["repsRest"];
  }
}