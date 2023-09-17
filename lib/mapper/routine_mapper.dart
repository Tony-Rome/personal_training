import '../dto/routine_dto.dart';

class RoutineMapper {

  RoutineDTO routineModelToRoutineDTO(Map<String, dynamic> data){
    RoutineDTO routineDTO = RoutineDTO();
    routineDTO
    ..id = data['id']
    ..name = data['name'];
    return routineDTO;
  }
}