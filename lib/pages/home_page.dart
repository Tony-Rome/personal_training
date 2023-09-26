import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_training/dto/exercise_dto.dart';
import 'package:personal_training/mapper/exercise_mapper.dart';

import '../helper/sql_helper.dart';
import '../main.dart';
import '../widget/exercise_list_widget.dart';
import '../widget/routine_list_widget.dart';
import 'routine_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  List<String> types = ["Crear una rutina", "", "Crear un ejercicio"];
  List<String> searchTypes = ["Buscar una rutina","","Buscar un ejercicio"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              _getSearchRutineOrExercise(),
              _getRutinesOrExercisesView()
            ],
          ),
        ),
        bottomNavigationBar: _getBottmNavigationBar(),
    );
  }

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
          hintText: searchTypes[currentIndex],
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.blue
        ),
      ),
    );
  }

  Widget _getRutinesOrExercisesView()
        => currentIndex == 0 ? RoutineList() : ExerciseList();

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
