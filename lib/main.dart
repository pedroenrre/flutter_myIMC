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
  TextEditingController weigthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados!';

  void _resetField() {
    setState(() {
      weigthController.text = '';
      heigthController.text = '';
      _infoText = 'Informe seus dados!';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weigth = double.parse(weigthController.text);
      double heigth = double.parse(heigthController.text) / 100;
      double imc = weigth / (heigth * heigth);

      if (imc < 18.6) {
        _infoText = 'Abaixo do peso (${imc.toStringAsFixed(2)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso ideal (${imc.toStringAsFixed(2)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente acima do peso (${imc.toStringAsFixed(2)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade grau I (${imc.toStringAsFixed(2)})';
      } else if (imc >= 34.9 && imc < 40) {
        _infoText = 'Obesidade grau II (${imc.toStringAsFixed(2)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade grau III (${imc.toStringAsFixed(2)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[400],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetField),
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
              dimension.width * 0.05, 0, dimension.width * 0.05, 0),
          child: Container(
            alignment: Alignment.topCenter,
            width: dimension.width * 0.9,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.person,
                      size: 200,
                      color: Colors.blueGrey[400],
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(color: Colors.blueGrey[400]),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey[400], fontSize: 25),
                    controller: weigthController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Ensira seu peso!';
                      }
                    },
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Altura (cm)',
                          labelStyle: TextStyle(color: Colors.blueGrey[400]),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blueGrey[400], fontSize: 25),
                        controller: heigthController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ensira sua altura!';
                          }
                        },
                      )),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      color: Colors.blueGrey[400],
                    ),
                  ),
                  Text(_infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueGrey[400],
                        fontSize: 25,
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
