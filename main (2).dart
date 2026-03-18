import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: StockMaster()));
}

class StockMaster extends StatelessWidget {
  // Lista estática de produtos
  final List<Map<String, dynamic>> produtos = [
    {
      "id": 1,
      "nome": "Teclado Mecânico",
      "qtdEstoque": 5,
      "precoUnitario": 250.0,
    },
    {"id": 2, "nome": "Mouse Gamer", "qtdEstoque": 20, "precoUnitario": 120.0},
    {"id": 3, "nome": "Monitor 24''", "qtdEstoque": 8, "precoUnitario": 900.0},
    {"id": 4, "nome": "Headset", "qtdEstoque": 15, "precoUnitario": 300.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StockMaster"), centerTitle: true),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];

          // RN01 - Alerta de stock crítico
          Color corFundo = produto["qtdEstoque"] < 10
              ? Colors.red.shade50
              : Colors.white;

          // RN02 - Cálculo do valor patrimonial
          double valorTotal = produto["qtdEstoque"] * produto["precoUnitario"];

          return Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: corFundo,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // RN03
              children: [
                // Nome do produto (esquerda)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produto["nome"],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Qtd: ${produto["qtdEstoque"]}"),
                  ],
                ),

                // Valor total (direita)
                Text(
                  "R\$ ${valorTotal.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
