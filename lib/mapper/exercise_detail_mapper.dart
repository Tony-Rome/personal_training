import 'package:personal_training/dto/complete_exercise_dto.dart';

class ExerciseDetailMapper {

  static Map<String, dynamic> completeExerciseDtoToExerciseDetailModel(CompleteExerciseDTO completeExerciseDTO) {
    return {
      'id': completeExerciseDTO.id,
      'sets': completeExerciseDTO.sets,
      'reps': completeExerciseDTO.reps,
      'lift': completeExerciseDTO.lift,
      'sets_rest': completeExerciseDTO.setsRest,
      'reps_rest': completeExerciseDTO.repsRest
    };
  }
}