import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class NewExerciseToRoutinePage extends StatefulWidget {
  const NewExerciseToRoutinePage({Key? key}) : super(key: key);

  @override
  State<NewExerciseToRoutinePage> createState() => _NewExerciseToRoutinePageState();
}

class _NewExerciseToRoutinePageState extends State<NewExerciseToRoutinePage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        margin: EdgeInsets.only(top:50),
        padding: EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: Column(
          children: [
            _getTitle(),
            _getSearchExerciseButton(),
            Container(
              color: Colors.grey,
              height: 600,
              width: double.maxFinite,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _getAddExerciseButton(),
                    _getTextFieldRoutineName(),
                    _getTextFieldSets(),
                    _getTextFieldReps(),
                    _getTextFieldMode(),
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
    );
  }

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Text("Nueva rutina",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30
          )
      ),
    );
  }

  Widget _getSearchExerciseButton(){
    return Container(
      width: 300,
      height: 45,
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (_){print("Searching ...");},
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, size: 25,),
            suffixIcon: Icon(Icons.dangerous),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(50)
            ),
            hintText: "Buscar un ejercicio",
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.blue
        ),
      ),
    );
  }

  Widget _getAddExerciseButton() {
    return Container(
      margin: EdgeInsets.only(top:20),
      child: ElevatedButton(
          onPressed: _saveExercise,
          child: Text("Agregar ejercicio"),
      ),
    );
  }

  Widget _getTextFieldRoutineName() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 250,
      height: 60,
      child: TextFormField(
        decoration: InputDecoration(label: Text("Nombre de rutina"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 30,
        //onSaved: (value) => routineDto.name = value!,
        validator: (value) => (value == null || value.isEmpty) ? "Nombre es requerido" : null,
      ),
    );
  }

  Widget _getTextFieldSets() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 250,
      height: 60,
      child: TextFormField(
        decoration: InputDecoration(label: Text("cantidad de sets"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 2,
        //onSaved: (value) => routineDto.name = value!,
        validator: (value) => (value == null || value.isEmpty) ? "Cantidad es requerida" : null,
      ),
    );
  }

  Widget _getTextFieldReps() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 250,
      height: 60,
      child: TextFormField(
        decoration: InputDecoration(label: Text("cantidad de reps"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 2,
        //onSaved: (value) => routineDto.name = value!,
        validator: (value) => (value == null || value.isEmpty) ? "Cantidad es requerida" : null,
      ),
    );
  }

  Widget _getTextFieldMode() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 250,
      height: 60,
      child: TextFormField(
        decoration: InputDecoration(label: Text("Modo"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 30,
        //onSaved: (value) => routineDto.name = value!,
        validator: (value) => (value == null || value.isEmpty) ? "Modo es requerida" : null,
      ),
    );
  }

  Widget _getTextFieldLift() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 250,
      height: 60,
      child: TextFormField(
        decoration: InputDecoration(label: Text("Peso"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 3,
        //onSaved: (value) => routineDto.name = value!,
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
        decoration: InputDecoration(label: Text("Descanso entre reps (min)"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 2,
        //onSaved: (value) => routineDto.name = value!,
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
        decoration: InputDecoration(label: Text("Descanso entre sets (min)"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 2,
        //onSaved: (value) => routineDto.name = value!,
        validator: (value) => (value == null || value.isEmpty) ? "Cantidad es requerida" : null,
      ),
    );
  }

  void _saveExercise(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    }
  }
}
