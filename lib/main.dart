import 'package:flutter/material.dart';
import 'cep_service.dart';
import 'cep_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca de CEP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Busca de CEP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _cepController = TextEditingController();
  CepModel? _cepModel;
  final CepService _cepService = CepService();

  void _buscarCep() async {
    final cep = _cepController.text;
    if (cep.isNotEmpty) {
      try {
        final cepModel = await _cepService.buscarCep(cep);
        setState(() {
          _cepModel = cepModel;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao buscar CEP')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'CEP',
              ),
            ),
            ElevatedButton(
              onPressed: _buscarCep,
              child: Text('Buscar CEP'),
            ),
            if (_cepModel != null)
              Text(
                'Logradouro: ${_cepModel!.logradouro}\nBairro: ${_cepModel!.bairro}\nLocalidade: ${_cepModel!.localidade}\nUF: ${_cepModel!.uf}',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
