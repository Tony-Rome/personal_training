import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_training/main.dart';
import 'package:personal_training/pages/home_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: Column(
          children: [
            _getIconApp(size.height),
            _geWelcomeTex(size.height),
            _getTitleApp(size.height),
            _getVersionApp(size.height),
            _getFeddbackText(size.height),
            _getInitButton(size.height),
            _getEmailContact(size.height),
            _getExtraText(size.height)
          ],
        ),
      ),
    );
  }

  Widget _getIconApp(double height){
    return Container(
      margin: EdgeInsets.only(top:height * 0.12),
      padding: EdgeInsets.all(height * 0.03),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(100)
      ),
      child: Icon(
          Icons.accessibility_new_outlined,
        size: height * 0.15,
      ),
    );
  }

  Widget _geWelcomeTex(double height){
    return Container(
      margin: EdgeInsets.only(top: height * 0.04),
      child: Text(
        "¡Bienvenido!",
        style: TextStyle(
            fontWeight: FontWeight.bold,
          fontSize: height * 0.035,
          color: Colors.white
        ),
      ),
    );
  }

  Widget _getTitleApp(double height){
    return Container(
      margin: EdgeInsets.only(top: height * 0.03),
      child: Text(
        "Planificación Personal",
        style: TextStyle(fontSize: height * 0.036
        ),
      ),
    );
  }

  Widget _getVersionApp(double height){
    return Container(
      margin: EdgeInsets.only(top:height * 0.025),
      alignment: Alignment.centerRight,
      child: const Text("Versión Bea 1.0",
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget _getFeddbackText(double height){
    return Container(
      margin: EdgeInsets.only(top: height * 0.025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Comenta "),
          GestureDetector(
            onTap: (){},
            child: Text("acá",
            style: TextStyle(
              fontSize: height * 0.01,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue,
              decorationThickness: 2
            ),
            ),
          ),
          const Text(" qué te parece  la app :)")
        ],
      ),
    );
  }

  Widget _getInitButton(double height){
    return Container(
      margin: EdgeInsets.only(top:height * 0.03),
      child: ElevatedButton(
          onPressed: () => MyApp.navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => HomePage()))
          ,
          style: ElevatedButton.styleFrom(
            elevation: 8,
            fixedSize: Size(double.maxFinite, height * 0.08)
          ),
          child: Text("Comenzar la planificación", style: TextStyle(color: Colors.black, fontSize: height * 0.022),)
      ),
    );
  }

  Widget _getEmailContact(double height){
    return Container(
      margin: EdgeInsets.only(top:height * 0.1),
      child: GestureDetector(
        onTap: (){},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("tonyn.rome@gmail.com", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),),
            Icon(Icons.mail, color: Colors.white,)
          ],
        ),
      ),
    );
  }

  Widget _getExtraText(double height){
    return Container(
      margin: EdgeInsets.only(top: height * 0.01),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Hecho con ", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),),
          Icon(Icons.heart_broken, color: Colors.red,)
        ],
      ),
    );
  }
}
