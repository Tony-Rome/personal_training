import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_training/dto/exercise_detail_dto.dart';
import 'package:personal_training/pages/create_rutine_page.dart';

import '../helper/sql_helper.dart';
import '../main.dart';

class NewExerciseToRoutinePage extends StatefulWidget {
  const NewExerciseToRoutinePage({Key? key}) : super(key: key);

  @override
  State<NewExerciseToRoutinePage> createState() => _NewExerciseToRoutinePageState();
}

class _NewExerciseToRoutinePageState extends State<NewExerciseToRoutinePage> {

  final _formKey = GlobalKey<FormState>();
  ExerciseDetailDTO exerciseDetailDTO = ExerciseDetailDTO();

  void _refreshExerciseDetail() async {
    final List<Map<String, dynamic>> data = await SqlHelper.getAllExerciseDetail();
    print('numeros de detalles ejercicios guardads: ${data.length}');

    if(data.isNotEmpty) print('Primer detalle ejercicio guardado: ${data[0]}');
  }

  @override
  void initState() {
    super.initState();
    _refreshExerciseDetail();
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
                      _getTextFieldExerciseName(),
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

  Widget _getTextFieldExerciseName() {
    return Container(
      margin: EdgeInsets.only(top:10),
      width: 250,
      height: 60,
      child: TextFormField(
        decoration: InputDecoration(label: Text("Nombre de ejercicio"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 30,
        onSaved: (value) => exerciseDetailDTO.name = value!,
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
        onSaved: (value) => exerciseDetailDTO.sets = int.parse(value!),
        validator: (value) => (value == null || value.isEmpty || value == '0') ? "Cantidad es requerida" : null,
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
        onSaved: (value) => exerciseDetailDTO.reps = int.parse(value!),
        validator: (value) => (value == null || value.isEmpty || value == '0') ? "Cantidad es requerida" : null,
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
        onSaved: (value) => exerciseDetailDTO.mode = value!,
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
        onSaved: (value) => exerciseDetailDTO.lift = int.parse(value!),
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
        onSaved: (value) => exerciseDetailDTO.repsRest = value!,
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
        onSaved: (value) => exerciseDetailDTO.setsRest = value!,
        validator: (value) => (value == null || value.isEmpty) ? "Cantidad es requerida" : null,
      ),
    );
  }

  void _saveExercise() async{
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      int newExerciseId = await SqlHelper
          .createExercise(
          exerciseDetailDTO.name!,
          exerciseDetailDTO.mode!,
          exerciseDetailDTO.description ?? "");
      SqlHelper
          .createExerciseDetail(
          exerciseDetailDTO.sets!,
          exerciseDetailDTO.reps!,
          exerciseDetailDTO.lift!,
          exerciseDetailDTO.setsRest!,
          exerciseDetailDTO.repsRest!,
          newExerciseId
      );
    }
    print(exerciseDetailDTO.toString());
  }

  void _back() {
    MyApp
        .navigatorKey
        .currentState?.push(
        MaterialPageRoute(
            builder: (_) => CreateRoutinePage()
        )
    );
  }
}
