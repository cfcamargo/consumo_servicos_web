import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

    TextEditingController _controllerCep = TextEditingController();

  String _resultado = "Resultado";

  _recuperarCep() async {
    String cep = _controllerCep.text;
    var url = Uri.parse("https://viacep.com.br/ws/${cep}/json/");
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];


    setState(() {
      _resultado = "${logradouro}, ${complemento}, ${bairro}";
    });

    // print("resposta: " + response.body);

    // print(
    //   "Resposta logradouro: ${logradouro}, complemento: ${complemento}, bairro: ${bairro}"
    // );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o cep: ex 05428200"
              ),
              style: TextStyle(
                fontSize: 20
              ),
              controller: _controllerCep,
            ),
            RaisedButton(
              child: Text("Clique Aqui"),
                onPressed: _recuperarCep,
            ),
            Padding(padding: EdgeInsets.only(top: 60),child: Text(_resultado))
          ],
        ),
      ),
    );
  }
}
