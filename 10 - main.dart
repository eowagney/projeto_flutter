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
      home: FleetManagerPage(),
    );
  }
}

// =============================
// PARTE 1 - MODELO
// =============================
class Veiculo {
  String modelo;
  double valor;
  bool isAlugado;

  Veiculo({
    required this.modelo,
    required this.valor,
    this.isAlugado = false,
  });
}

// =============================
// PARTE 2 - INTERFACE
// =============================
class FleetManagerPage extends StatefulWidget {
  const FleetManagerPage({super.key});

  @override
  State<FleetManagerPage> createState() => _FleetManagerPageState();
}

class _FleetManagerPageState extends State<FleetManagerPage> {
  final TextEditingController modeloController = TextEditingController();
  final TextEditingController valorController = TextEditingController();

  List<Veiculo> frota = [];
  List<Veiculo> listaExibida = [];

  void cadastrarVeiculo() {
    String modelo = modeloController.text.trim();
    double valor = double.tryParse(valorController.text) ?? 0.0;

    Veiculo novo = Veiculo(modelo: modelo, valor: valor);

    setState(() {
      frota.add(novo);
      listaExibida = List.from(frota);
    });

    // forEach - imprimir frota no console
    frota.forEach((v) {
      print("Modelo: ${v.modelo} | Valor: ${v.valor}");
    });

    // firstWhere - encontrar veículo de 50.000
    try {
      Veiculo encontrado = frota.firstWhere((v) => v.valor == 50000);
      print("Veículo encontrado com 50.000: ${encontrado.modelo}");
    } catch (e) {
      print("Nenhum veículo com valor 50.000 encontrado.");
    }

    // every - validar nomes
    bool todosTemNome = frota.every((v) => v.modelo.isNotEmpty);
    print("Todos veículos possuem nome? $todosTemNome");

    modeloController.clear();
    valorController.clear();
  }

  void filtrarDisponiveis() {
    setState(() {
      listaExibida = frota.where((v) => !v.isAlugado).toList();
    });
  }

  void ordenarPorPreco() {
    setState(() {
      listaExibida.sort((a, b) => a.valor.compareTo(b.valor));
    });
  }

  @override
  Widget build(BuildContext context) {
    double valorTotal = frota.fold(0.0, (total, v) => total + v.valor);
    bool existeVeiculoCaro = frota.any((v) => v.valor > 100000);

    return Scaffold(
      appBar: AppBar(
        title: const Text("FleetManager 2026"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // FORMULÁRIO
            TextField(
              controller: modeloController,
              decoration: const InputDecoration(
                labelText: "Modelo",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Valor",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: cadastrarVeiculo,
              child: const Text("Cadastrar"),
            ),
            const SizedBox(height: 20),

            // FILTROS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: filtrarDisponiveis,
                  child: const Text("Ver apenas disponíveis"),
                ),
                ElevatedButton(
                  onPressed: ordenarPorPreco,
                  child: const Text("Ordenar por Preço"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // INDICADORES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Valor Total da Frota: R\$ ${valorTotal.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                if (existeVeiculoCaro)
                  const Icon(Icons.warning, color: Colors.orange),
              ],
            ),
            const SizedBox(height: 20),

            // LISTAGEM
            Expanded(
              child: ListView.builder(
                itemCount: listaExibida.length,
                itemBuilder: (context, index) {
                  Veiculo v = listaExibida[index];
                  return Card(
                    child: ListTile(
                      title: Text(v.modelo),
                      subtitle: Text("R\$ ${v.valor.toStringAsFixed(2)}"),
                      trailing: Icon(
                        v.isAlugado ? Icons.lock : Icons.lock_open,
                        color: v.isAlugado ? Colors.red : Colors.green,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
