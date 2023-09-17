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
}