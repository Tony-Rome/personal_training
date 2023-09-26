import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:personal_training/dto/complete_exercise_dto.dart';
import 'package:personal_training/helper/exercise_detail_helper.dart';
import 'package:personal_training/mapper/exercise_mapper.dart';
import 'package:personal_training/pages/home_page.dart';
import 'package:personal_training/pages/update_exercise_detail_page.dart';

import '../helper/routine_helper.dart';
import '../main.dart';
import 'new_exercise_to_routine_page.dart';

class RoutineDetailPage extends StatefulWidget {

  final String routineName;
  final int routineId;

  const RoutineDetailPage(
      {Key? key,
        required this.routineName,
        required this.routineId}) : super(key: key);

  @override
  State<RoutineDetailPage> createState() => _RoutineDetailPageState();
}

class _RoutineDetailPageState extends State<RoutineDetailPage> {

  List<CompleteExerciseDTO>  listOfExercises = [];

  void _refreshCompleteRoutine(int routineId) async {
   List<Map<String, dynamic>> allExerciseByRoutineId = await RoutineHelper.getCompleteRoutineByRoutineId(routineId);
   print("All exercise by routine id: $routineId are ${allExerciseByRoutineId.length}");
   if(allExerciseByRoutineId.isNotEmpty){
      setState(() {
        listOfExercises = allExerciseByRoutineId
            .map((exerciseAndDetail) =>
                ExerciseMapper.exerciseAndExerciseDetailModelToCompleteExercise(
                    exerciseAndDetail))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshCompleteRoutine(widget.routineId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: Icon(Icons.arrow_back, size: 45, color: Colors.white),
        onPressed: _back,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top:50),
          padding: EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                height: 680,
                width: double.maxFinite,
                child: Column(
                  children: [
                    _getTextFieldRoutineName(),
                    _getAddExerciseButton(),
                    Container(
                      height: 420,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)
                      ),
                      child: Column(
                        children: [
                          _getTitleOfExerciseList(),
                          _getAllExerciseByRoutine()
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTextFieldRoutineName() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top:10),
      height: 50,
      width: double.maxFinite,
      child: Text(widget.routineName, style: TextStyle(fontSize: 30),)
    );
  }

  Widget _getAddExerciseButton() {
    return Container(
      margin: const EdgeInsets.only(top:25, bottom: 25),
      child: ElevatedButton(
          onPressed: () => MyApp
              .navigatorKey
              .currentState?.push(
              MaterialPageRoute(
                  builder: (_) => NewExerciseToRoutinePage(routineName: widget.routineName, routineId: widget.routineId)
              )
          ),
          style: ElevatedButton.styleFrom(
              elevation: 8,
              fixedSize: const Size(250, 40)
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Agregar ejercicio"),
              Icon(Icons.add)
            ],
          )
      ),
    );
  }

  Widget _getTitleOfExerciseList(){
    return Text(
        "Ejercicios de la rutina",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget _getAllExerciseByRoutine(){
    return Expanded(
        child: ListView.builder(
            itemCount: listOfExercises.length,
            itemBuilder: (_, index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: "Borrar",
                        onPressed: (_) => _deleteExerciseDetail(listOfExercises[index].id!, index)
                    )
                  ],
                ),
                child: ListTile(
                  onTap: () => _updateExerciseDetail(listOfExercises[index]),
                  leading: Text((index + 1).toString()),
                  title: Text('${listOfExercises[index].name!} - ${listOfExercises[index].mode!}'),
                  subtitle: Text('${listOfExercises[index].sets!} x ${listOfExercises[index].reps!} + ${listOfExercises[index].lift!}kg'),
                  trailing: Icon(Icons.remove_red_eye_outlined),
                ),
              );
            }
        )
    );
  }

  void _back() {
    MyApp
        .navigatorKey
        .currentState?.push(
        MaterialPageRoute(
            builder: (_) => HomePage()
        )
    );
  }

  void _updateExerciseDetail(CompleteExerciseDTO completeExerciseDTO) {
    MyApp
        .navigatorKey
        .currentState?.push(
        MaterialPageRoute(
            builder: (_) => UpdateExerciseDetailPage(
              completeExerciseDTO: completeExerciseDTO,
              routineName: widget.routineName,
              routineId: widget.routineId,)
        )
    );
  }

  void _deleteExerciseDetail(int exerciseDetailId, int index) {
    ExerciseDetailHelper
        .deleteExerciseDetail(exerciseDetailId)
        .then((_) {
          setState(() {
            listOfExercises.removeAt(index);
          });
    });
  }
}
