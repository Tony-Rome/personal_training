import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'create_exercise_page.dart';
import 'create_rutine_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  List<String> types = ["Crear una rutina", "", "Crear un ejercicio"];

  List<String> exercisesList = ["Biceps con mancuernas", "Abdomen con barras", "Estocadas", "Curl de biceps invertido"];
  List<String> rutinesList = ["Solo tronco superior", "Piernas y glúteos", "Core con barras calistenia", "Bicicleta"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              _getCreateExerciseButton(),
              _getSearchRutineOrExercise(),
              _getRutinesOrExercisesView()
            ],
          ),
        ),
        bottomNavigationBar: _getBottmNavigationBar(),
    );
  }

  Widget _getCreateExerciseButton(){
    return Container(
      margin: EdgeInsets.only(top: 80),
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: _createRutineOrExercise,
          style: ElevatedButton.styleFrom(
              elevation: 8,
              fixedSize: Size(300, 30)
          ),
          child: Text(types[currentIndex], style: TextStyle(color: Colors.black, fontSize: 15),)
      ),
    );
  }

  void _createRutineOrExercise() {
    MyApp
        .navigatorKey
        .currentState?.push(
        MaterialPageRoute(
            builder: (_) => currentIndex == 0 ? CreateRoutinePage() : CreateExercisePage()
        )
    );
  }

  // TODO: setState para cambiar el label si es ejercicio o rutina
  Widget _getSearchRutineOrExercise(){
    return Container(
      margin: EdgeInsets.only(top: 80),
      alignment: Alignment.center,
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (_){print("Searching ...");},
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, size: 30,),
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

  Widget _getRutinesOrExercisesView(){
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top:25),
        width: double.maxFinite,
        color: Colors.grey[200],
        child: currentIndex == 0 ? _getListofRutines() : _getListofExercises()

      ),
    );
  }

  Widget _getListofRutines() {
    return new ListView(
      children: rutinesList.map((rutine) => Text(rutine)).toList(),
    );
  }

  Widget _getListofExercises() {
    return new ListView(
      children: exercisesList.map((exercise) => Text(exercise)).toList(),
    );
  }

  Widget _getBottmNavigationBar(){
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      onTap: _onTap,
      currentIndex: currentIndex,
      selectedItemColor: Colors.black54,
      unselectedItemColor: Colors.grey.withOpacity(0.5),
      showUnselectedLabels: false,
      showSelectedLabels: true,
      elevation: 8.0,
      items: [
        BottomNavigationBarItem(label: "Rutinas", icon: Icon(Icons.expand)),
        BottomNavigationBarItem(
            label: "",
            icon: Container(color: Colors.black, width: 2, height: 30,)
        ),
        BottomNavigationBarItem(label: "Ejercicios", icon: Icon(Icons.expand)),
      ],
    );
  }

  void _onTap(int index) {

    if(index == 1){ return; }

    setState(() => currentIndex = index);
  }
}
