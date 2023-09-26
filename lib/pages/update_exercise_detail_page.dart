import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_training/dto/complete_exercise_dto.dart';
import 'package:personal_training/dto/exercise_detail_dto.dart';
import 'package:personal_training/mapper/exercise_detail_mapper.dart';
import 'package:personal_training/pages/routine_detail_page.dart';

import '../helper/exercise_detail_helper.dart';
import '../helper/sql_helper.dart';
import '../main.dart';

class UpdateExerciseDetailPage extends StatefulWidget {

  final CompleteExerciseDTO completeExerciseDTO;
  final String routineName;
  final int routineId;

  const UpdateExerciseDetailPage(
      {super.key,
        required this.completeExerciseDTO,
        required this.routineName,
        required this.routineId});

  @override
  State<UpdateExerciseDetailPage> createState() => _UpdateExerciseDetailPageState();
}

class _UpdateExerciseDetailPageState extends State<UpdateExerciseDetailPage> {

  final _formKey = GlobalKey<FormState>();

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
              _getTitle(),
              Container(
                color: Colors.grey,
                height: 600,
                width: double.maxFinite,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _getAddExerciseButton(),
                      _getTextFieldSets(),
                      _getTextFieldReps(),
                      _getTextFieldLift(),
                      _getTextFieldRestTimeReps(),
                      _getTextFieldRestTimeSets()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Text(widget.completeExerciseDTO.name!,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 30
          )
      ),
    );
  }

  Widget _getAddExerciseButton() {
    return Container(
      margin: EdgeInsets.only(top:20),
      child: ElevatedButton(
        onPressed: _updateExerciseDetail,
        child: Text("Actualizar ejercicio"),
      ),
    );
  }

  Widget _getTextFieldSets() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 250,
      height: 60,
      child: TextFormField(
        initialValue: widget.completeExerciseDTO.sets.toString(),
        decoration: InputDecoration(label: Text("cantidad de sets"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 2,
        onSaved: (value) => widget.completeExerciseDTO.sets = int.parse(value!),
        validator: (value) => (value == null || value.isEmpty || value == '0') ? "Cantidad es requerida" : null,
      ),
    );
  }

  Widget _getTextFieldReps() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 320,
      height: 120,
      child: TextFormField(
        initialValue: widget.completeExerciseDTO.reps.toString(),
        decoration: InputDecoration(
            label: Text("cantidad de reps"),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder()
        ),
        maxLength: 2,
        onSaved: (value) => widget.completeExerciseDTO.reps = int.parse(value!),
        validator: (value) => (value == null || value.isEmpty || value == '0') ? "Cantidad es requerida" : null,
      ),
    );
  }

  Widget _getTextFieldLift() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 250,
      height: 60,
      child: TextFormField(
        initialValue: widget.completeExerciseDTO.lift.toString(),
        decoration: InputDecoration(label: Text("Peso"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 3,
        onSaved: (value) => widget.completeExerciseDTO.lift = int.parse(value!),
        validator: (value) => (value == null || value.isEmpty) ? "Peso es requerida" : null,
      ),
    );
  }

  Widget _getTextFieldRestTimeReps() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 250,
      height: 60,
      child: TextFormField(
        initialValue: widget.completeExerciseDTO.repsRest ?? "0",
        decoration: InputDecoration(label: Text("Descanso entre reps (min)"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 2,
        onSaved: (value) => widget.completeExerciseDTO.repsRest = value!,
        validator: (value) => (value == null || value.isEmpty) ? "Cantidad es requerida" : null,
      ),
    );
  }

  Widget _getTextFieldRestTimeSets() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 250,
      height: 60,
      child: TextFormField(
        initialValue: widget.completeExerciseDTO.setsRest ?? "0",
        decoration: InputDecoration(label: Text("Descanso entre sets (min)"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 2,
        onSaved: (value) => widget.completeExerciseDTO.setsRest = value!,
        validator: (value) => (value == null || value.isEmpty) ? "Cantidad es requerida" : null,
      ),
    );
  }

  void _updateExerciseDetail() async{
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> exerciseDetail = ExerciseDetailMapper.completeExerciseDtoToExerciseDetailModel(widget.completeExerciseDTO);

      // Se actualiza ejercicio detalle
      ExerciseDetailHelper.updateExerciseDetail(exerciseDetail);
    }
  }

  void _back() {
    MyApp
        .navigatorKey
        .currentState?.push(
        MaterialPageRoute(
            builder: (_) => RoutineDetailPage(routineName: widget.routineName, routineId: widget.routineId)
        )
    );
  }
}
