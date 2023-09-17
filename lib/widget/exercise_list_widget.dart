import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dto/exercise_dto.dart';
import '../helper/sql_helper.dart';
import '../mapper/exercise_mapper.dart';

class ExerciseList extends StatefulWidget {
  const ExerciseList({super.key});

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {

  List<ExerciseDTO> exercisesList = [];

  void _refreshExercise() async {
    final List<Map<String, dynamic>> data = await SqlHelper.getExercises();
    print('numeros de ejercicios guardads: ${data.length}');
    if(data.isNotEmpty){
      setState(() {
        exercisesList = data
            .map(
                (exerciseModel) => ExerciseMapper()
                .exerciseModelToExerciseDtoMapper(exerciseModel)
        ).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshExercise();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: EdgeInsets.only(top:25),
          width: double.maxFinite,
          color: Colors.grey[200],
          child: _getListofExercises()

      ),
    );
  }

  Widget _getListofExercises() {
    return ListView.builder(
        itemCount: exercisesList.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: Text(exercisesList[index].id!.toString()),
            title: Text(exercisesList[index].name!, style: TextStyle(color: Colors.black),),
            trailing: Icon(Icons.remove_red_eye_outlined),
          );
        }
    );
  }
}
