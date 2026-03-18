import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CombustivelPage(),
    );
  }
}

class CombustivelPage extends StatefulWidget {
  const CombustivelPage({super.key});

  @override
  State<CombustivelPage> createState() => _CombustivelPageState();
}

class _CombustivelPageState extends State<CombustivelPage> {
  final TextEditingController alcoolController = TextEditingController();
  final TextEditingController gasolinaController = TextEditingController();

  String nivel = "Básico";
  String resultado = "";
  double valorFinal = 0.0;
  bool? isAlcool;

  void calcular() {
    double alcool = double.tryParse(alcoolController.text) ?? 0.0;
    double gasolina = double.tryParse(gasolinaController.text) ?? 0.0;

    if (alcool == 0 || gasolina == 0) {
      setState(() {
        resultado = "Informe valores válidos";
      });
      return;
    }

    // Regra dos 70%
    isAlcool = alcool <= gasolina * 0.7;

    double precoEscolhido = isAlcool! ? alcool : gasolina;

    double desconto = 0.0;

    // Uso do switch
    switch (nivel) {
      case "Prata":
        desconto = 0.02;
        break;
      case "Ouro":
        desconto = 0.05;
        break;
      default:
        desconto = 0.0;
    }

    valorFinal = precoEscolhido - (precoEscolhido * desconto);

    setState(() {
      resultado = isAlcool! ? "Álcool é mais vantajoso" : "Gasolina é mais vantajosa";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comparador de Combustível"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: alcoolController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Preço do Álcool",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: gasolinaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Preço da Gasolina",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: nivel,
              decoration: const InputDecoration(
                labelText: "Nível de Fidelidade",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "Básico", child: Text("Básico")),
                DropdownMenuItem(value: "Prata", child: Text("Prata")),
                DropdownMenuItem(value: "Ouro", child: Text("Ouro")),
              ],
              onChanged: (value) {
                setState(() {
                  nivel = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcular,
              child: const Text("Calcular"),
            ),
            const SizedBox(height: 20),
            if (resultado.isNotEmpty)
              Column(
                children: [
                  // Uso do operador ternário
                  Icon(
                    isAlcool == true ? Icons.local_gas_station : Icons.local_gas_station,
                    color: isAlcool == true ? Colors.green : Colors.amber,
                    size: 60,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    resultado,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Valor final com desconto: R\$ ${valorFinal.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
