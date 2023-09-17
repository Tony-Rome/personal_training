import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_training/dto/routine_dto.dart';
import 'package:personal_training/helper/sql_helper.dart';
import 'package:personal_training/mapper/routine_mapper.dart';

class RoutineList extends StatefulWidget {
  const RoutineList({super.key});

  @override
  State<RoutineList> createState() => _RoutineListState();
}

class _RoutineListState extends State<RoutineList> {

  final TextEditingController _textEditingController = TextEditingController();
  List<RoutineDTO> routinesList = [];

  void _refreshRoutines() async {
    final List<Map<String, dynamic>> data = await SqlHelper.getRoutines();
    print('numeros de rutinas guardads: ${data.length}');
    if(data.isNotEmpty){
      setState(() {
        routinesList = data
            .map(
                (routineModel) => RoutineMapper()
                .routineModelToRoutineDTO(routineModel)
        ).toList();
      });
    }

  }

  Future<void> _saveNewRoutineName(String text) async{
    print("Valor agregado : $text");
    int newRoutineId = await SqlHelper.createRoutine(text);
    Map<String, dynamic> data = {
      'id': newRoutineId,
      'name': text
    };

    Future.delayed(Duration(seconds: 2));

    _textEditingController.clear();

    Navigator.of(context).pop();

    setState(() {
      routinesList.add(RoutineMapper().routineModelToRoutineDTO(data));
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshRoutines();
  }

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
          margin: EdgeInsets.only(top:25),
          width: double.maxFinite,
          color: Colors.grey[200],
          child: Stack(children:[
            _getListofRutines(),
            _addRoutineNameButton(context)
          ]
          )

      ),
    );
  }

  Widget _getListofRutines() {
    return ListView.builder(
      itemCount: routinesList.length,
      itemBuilder: (_, index){
        return ListTile(
          leading: Text(routinesList[index].id!.toString()),
          title: Text(routinesList[index].name!, style: TextStyle(color: Colors.black),),
          trailing: Icon(Icons.remove_red_eye_outlined),
        );
      },
    );
  }

  Widget _addRoutineNameButton(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 180, top: 300),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(160,50)
          ),
          onPressed: () async {
             await _routineNameShowDialog(context);
            },
            child: Row(
            children: [
            Text("Nueva rutina"),
              Icon(Icons.add)
            ],
          ),
        )
    );
  }

  Future<void> _routineNameShowDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

          bool _loading = false;

          return StatefulBuilder(
            builder:(context, setState) {
              return AlertDialog(
                title: Text(_loading ? "Guardando rutina" : "Nueva rutina"),
                content: _loading ? _showLoadingIcon() : _addNewRoutineNameButton(),
                actions: [
                  TextButton(
                      onPressed: () async {
                        setState((){
                          _loading = true;
                        });
                        await _saveNewRoutineName(_textEditingController.text);
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

  Widget _addNewRoutineNameButton(){
    return Container(
      margin: EdgeInsets.only(top:10),
      //height: 50,
      //width: 250,
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(label: Text("Nombre"),
            fillColor: Colors.white,
            filled: true
        ),
        maxLength: 30,
      ),
    );
  }
}
