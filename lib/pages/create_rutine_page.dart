import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_training/pages/home_page.dart';

import '../main.dart';
import 'new_exercise_to_routine_page.dart';

class CreateRoutinePage extends StatefulWidget {
  const CreateRoutinePage({Key? key}) : super(key: key);

  @override
  State<CreateRoutinePage> createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {

  List<String>  listOfExercises = ["Jalón pecho con máquina","Pull up ancho","Sentadilla globat"];

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
              _getAddRoutineButton(),
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
                          Expanded(
                              child: ListView.builder(
                                itemCount: listOfExercises.length,
                                  itemBuilder: (_, index) {
                                    return ListTile(
                                      leading: Text((index + 1).toString()),
                                      title: Text(listOfExercises[index]),
                                      trailing: Icon(Icons.remove_red_eye_outlined),
                                    );
                                  }
                              )
                          )
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

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Text("Nueva rutina",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30
          )
      ),
    );
  }

  Widget _getAddRoutineButton() {
    return Container(
      margin: EdgeInsets.only(top:25, bottom: 25),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              elevation: 8,
              fixedSize: Size(300, 30)
          ),
          child: Text("Agregar rutina")
      ),
    );
  }

  Widget _getTextFieldRoutineName() {
    return Container(
      margin: EdgeInsets.only(top:10),
      height: 50,
      width: 250,
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

  Widget _getAddExerciseButton() {
    return Container(
      margin: EdgeInsets.only(top:25, bottom: 25),
      child: ElevatedButton(
          onPressed: () => MyApp
              .navigatorKey
              .currentState?.push(
              MaterialPageRoute(
                  builder: (_) => NewExerciseToRoutinePage()
              )
          ),
          style: ElevatedButton.styleFrom(
              elevation: 8,
              fixedSize: Size(250, 40)
          ),
          child: Row(
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

  void _back() {
    MyApp
        .navigatorKey
        .currentState?.push(
        MaterialPageRoute(
            builder: (_) => HomePage()
        )
    );
  }
}
