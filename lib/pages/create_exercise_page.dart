import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_training/dto/exercise_dto.dart';

class CreateExercisePage extends StatefulWidget {
  const CreateExercisePage({Key? key}) : super(key: key);

  @override
  State<CreateExercisePage> createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {

  final _formKey = GlobalKey<FormState>();
  ExerciseDTO exerciseDTO = ExerciseDTO();
  List<String> _listOfModes = ['Eliga modo','Máquina', 'Peso corporal', 'Implementos'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top:50),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _getTitle(),
                Container(
                  color: Colors.grey,
                  height: 680,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      _getAddExerciseButton(),
                      _getTextFieldExerciseName(),
                      _getExerciseMode(),
                      _getDescriptionField()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Text("Nuevo ejercicio",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30
          )
      ),
    );
  }

  Widget _getAddExerciseButton() {
    return Container(
      margin: EdgeInsets.only(top:25, bottom: 25),
      child: ElevatedButton(
          onPressed: _saveExercise,
          style: ElevatedButton.styleFrom(
              elevation: 8,
              fixedSize: Size(250, 40)
          ),
          child: Text("Guardar")
      ),
    );
  }

  Widget _getTextFieldExerciseName() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 250,
      child: TextFormField(
        decoration: InputDecoration(label: Text("Nombre de ejercicio"),
          fillColor: Colors.white,
          filled: true
        ),
        maxLength: 30,
        onSaved: (value) => exerciseDTO.name = value!,
        validator: (value) => (value == null || value.isEmpty) ? "Nombre es requerido" : null,
      ),
    );
  }

  Widget _getExerciseMode() {
    return Container(
      width: 250,
      margin: EdgeInsets.only(top:10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(label: Text("Modo de ejercicio"),
          filled: true,
          fillColor: Colors.white
        ),
          items: _listOfModes
              .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value)
                  )
          ).toList(),
          onChanged: (_){},
          onSaved: (value) => exerciseDTO.mode = value!,
          validator: (value) => (value == null || value.isEmpty || value == _listOfModes[0]) ? 'Debe elegir un modo' : null,
      ),
    );
  }

  Widget _getDescriptionField() {
    return Container(
      width: 250,
      margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        decoration: InputDecoration(label: Text("Descripción"),
          fillColor: Colors.white,
          filled: true,
          alignLabelWithHint: true,
          contentPadding: EdgeInsets.only(left: 8)
        ),
        maxLength: 250,
        onSaved: (value) => exerciseDTO.description = value!,
        maxLines: 8,
        validator: (value) => (value == null || value.isEmpty) ? 'Debe contener descripcion' : null,
        textAlignVertical: TextAlignVertical.top,
      ),
    );
  }

  void _saveExercise(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    }
    print(exerciseDTO.toString());
  }
}
