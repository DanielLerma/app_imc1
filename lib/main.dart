import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(IMCApp());

class IMCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(primaryColor: Colors.green),
      home: IMCState(),
    );
  }
}

class IMCState extends StatefulWidget {
  IMCState({
    Key? key,
  }) : super(key: key);

  @override
  Imc createState() => Imc();
}

class Imc extends State<IMCState> {
  bool femaleClicked = false;
  bool maleClicked = false;
  double imc = 0.0;
  var heightController = TextEditingController();
  var weightController = TextEditingController();

  double imcCalculation() {
    var height = double.parse(heightController.text ?? "0");
    var weight = double.parse(weightController.text ?? "0");
    imc = weight / pow(height, 2);
    return (imc);
  }

  final String _mj = ''' 
  Tabla del IMC para mujeres
  Edad      IMC ideal 
  16-17     19-24 
  18-18       19-24   
  19-24     19-24 
  25-34     20-25 
  35-44     21-26 
  45-54     22-27 
  55-64     23-28 
  65-90     25-30
  ''';
  final String _hb = ''' 
  Tabla del IMC para hombres
  Edad      IMC ideal 
  16-16       19-24   
  17-17       20-25   
  18-18       20-25   
  19-24     21-26 
  25-34     22-27 
  35-54     23-38 
  55-64     24-29 
  65-90     25-30
    ''';

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tu IMC: ${imc.toStringAsFixed(2)}'),
          content: Text('${femaleClicked ? _mj : _hb}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calcular IMC'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
                heightController.clear();
                weightController.clear();
                femaleClicked = false;
                maleClicked = false;
                setState(() {});
              },
            )
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ingrese sus datos para calcular el IMC',
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.female,
                      color: femaleClicked ? Colors.indigo : Colors.grey),
                  iconSize: 24,
                  onPressed: () {
                    print("Female");
                    femaleClicked = !femaleClicked;
                    if (maleClicked) {
                      maleClicked = !maleClicked;
                    }
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(Icons.male,
                      color: maleClicked ? Colors.indigo : Colors.grey),
                  iconSize: 24,
                  onPressed: () {
                    print("Male");
                    maleClicked = !maleClicked;
                    if (femaleClicked) {
                      femaleClicked = !femaleClicked;
                    }
                    print(maleClicked);
                    setState(() {});
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.square_foot),
              title: Padding(
                padding: EdgeInsets.only(right: 24),
                child: TextField(
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Ingresar altura (metros)",
                      border: OutlineInputBorder(),
                    )),
              ),
            ),
            ListTile(
              leading: Icon(Icons.monitor_weight),
              title: Padding(
                padding: EdgeInsets.only(right: 24),
                child: TextField(
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Ingresar peso (Kg)",
                      border: OutlineInputBorder(),
                    )),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: MaterialButton(
                      child: Text("CALCULATE",
                          style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        // print("Valor del text field: ${tipController.text}");
                        _showMyDialog();
                        print(imcCalculation().toStringAsFixed(2));
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
