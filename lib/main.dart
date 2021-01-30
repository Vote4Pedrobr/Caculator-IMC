import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController heightcontroller = TextEditingController();

  GlobalKey <FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields(){
    weightcontroller.text = "";
    heightcontroller.text = "";
    setState(() {
      _infoText = "Informe seus dados.";
      _formKey = GlobalKey<FormState>();
    });

  }

  void _calculation () {

    setState(() {
      double weight = double.parse(weightcontroller.text);
      if (weight < 0) {
        weight = weight * (-1);
      }

      double height = double.parse(heightcontroller.text) / 100;
      if (height < 0) {
        height = height * (-1);
      }
      double imc = (weight / (height * height));

      if (imc % 1 != 0) {
        _infoText = "Insira um numero valido, sem '.' ou ',' ";
      }
      else if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
      }
      else if (imc >= 18.6 &&  imc <= 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(2)}";
      }
      else if (imc >= 24.9 &&  imc <= 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(2)}";
      }
      else if (imc >= 29.9 &&  imc <= 34.9) {
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(2)}";
      }
      else if (imc >= 34.9 &&  imc <= 39.9) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(2)}";
      }
      else if (imc >= 40.0) {
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(2)}";
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)],
        ),
        backgroundColor: Colors.yellow,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_pin_sharp,
                size: 120.0,
                color: Colors.blue,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
                controller: weightcontroller,
                validator: (value) {
                  if (value.isEmpty){
                    return "Insira seu Peso, seu animal!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
                controller: heightcontroller,
                validator: (value) {
                  if (value.isEmpty){
                    return "Insira sua Altura, seu animal!";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()){
                        _calculation();
                      };
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),)
        ));
  }
}
