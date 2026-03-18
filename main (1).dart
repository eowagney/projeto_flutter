import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConfiguracaoMoeda(
        taxaCambio: 5.0,
        nomeMoeda: "Dólar",
      ),
    );
  }
}

class ConfiguracaoMoeda extends StatefulWidget {
  final double taxaCambio;
  final String nomeMoeda;

  const ConfiguracaoMoeda({
    Key? key,
    required this.taxaCambio,
    required this.nomeMoeda,
  }) : super(key: key);

  @override
  _ConfiguracaoMoedaState createState() => _ConfiguracaoMoedaState();
}

class _ConfiguracaoMoedaState extends State<ConfiguracaoMoeda> {

  double valorConvertido = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor para ${widget.nomeMoeda}"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                labelText: "Valor em Reais",

                prefixIcon: Icon(Icons.attach_money),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              onChanged: (valor) {

                double reais = double.tryParse(valor) ?? 0;

                setState(() {
                  valorConvertido = reais * widget.taxaCambio;
                });

              },
            ),

            SizedBox(height: 30),

            Text(
              "Valor em ${widget.nomeMoeda}: "
              "${valorConvertido.toStringAsFixed(2)}",

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}