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
  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ExerciseDTO exerciseDTO = ExerciseDTO();
  List<String> _listOfModes = ['Eliga modo','Máquina', 'Peso corporal', 'Implementos'];


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
          child: Stack(
              children: [
                _getListofExercises(),
                _addNewExerciseButton(context)
              ]
          )

      ),
    );
  }

  Widget _getListofExercises() {
    return ListView.builder(
        itemCount: exercisesList.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: Text(index.toString()),
            title: Text(exercisesList[index].name!, style: TextStyle(color: Colors.black),),
            trailing: Icon(Icons.remove_red_eye_outlined),
          );
        }
    );
  }

  Widget _addNewExerciseButton(BuildContext context){
    return Container(
        margin: EdgeInsets.only(left: 160, top: 300),
        child: ElevatedButton(
          onPressed: () async {
            await _NewExerciseShowDialog(context);
          },
          child: Row(
            children: [
              Text("Nuevo ejercicio"),
              Icon(Icons.add)
            ],
          ),
        )
    );
  }

  Future<void> _NewExerciseShowDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

          bool _loading = false;

          return StatefulBuilder(
            builder:(context, setState) {
              return AlertDialog(
                title: Text(_loading ? "Guardando ejercicio" : "Nuevo ejercicio"),
                content: _loading ? _showLoadingIcon() : _addNewExerciseForm(),
                actions: [
                  TextButton(
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          setState((){ _loading = true;});
                          await _saveExercise();
                        }
                      },
                      child: const Text("Guardar")),
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancelar"))
                ],
              );
            },
          );
        }
    );
  }

  Widget _showLoadingIcon(){
    return CircularProgressIndicator();
  }

  Widget _addNewExerciseForm(){
    return Container(
      margin: EdgeInsets.only(top:10),
      //height: 50,
      //width: 250,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _getTextFieldExerciseName(),
              _getExerciseMode(),
              _getDescriptionField()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveExercise() async {
    _formKey.currentState!.save();
    int newExerciseId = await SqlHelper.createExercise(exerciseDTO.name!, exerciseDTO.mode!, exerciseDTO.description!);
    exerciseDTO.id = newExerciseId;
    print(exerciseDTO.toString());
    Navigator.of(context).pop();
    setState(() {
      exercisesList.add(exerciseDTO);
    });
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
}
