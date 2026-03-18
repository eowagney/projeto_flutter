import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SalesInsight()));
}

// 🔷 MODEL (PROFISSIONAL)
class Venda {
  final String cliente;
  final String categoria;
  final double valorVenda;

  Venda({
    required this.cliente,
    required this.categoria,
    required this.valorVenda,
  });
}

// 🔷 APP
class SalesInsight extends StatelessWidget {
  SalesInsight({super.key});

  // 🔥 LISTA COMPLETA
  final List<Venda> vendas = [
    Venda(
      cliente: "Notebook Dell XPS",
      categoria: "Eletrónicos",
      valorVenda: 15000,
    ),
    Venda(cliente: "Mouse Sem Fio", categoria: "Eletrónicos", valorVenda: 250),
    Venda(
      cliente: "Monitor LED 27\"",
      categoria: "Eletrónicos",
      valorVenda: 28000,
    ),
    Venda(cliente: "Cabo HDMI 2m", categoria: "Eletrónicos", valorVenda: 120),
    Venda(cliente: "Mariana Lopes", categoria: "Eletrónicos", valorVenda: 7200),
    Venda(cliente: "Camisa Nike", categoria: "Vestuário", valorVenda: 180),
    Venda(cliente: "Arroz 5kg", categoria: "Alimentos", valorVenda: 40),
  ];

  @override
  Widget build(BuildContext context) {
    // ✅ RN01 - FILTRO
    final vendasFiltradas = vendas
        .where((v) => v.categoria == "Eletrónicos")
        .toList();

    // 🔢 MÉTRICAS
    int totalProdutos = vendasFiltradas.length;

    double receitaTotal = vendasFiltradas.fold(
      0.0,
      (total, v) => total + v.valorVenda,
    );

    int vendasPremium = vendasFiltradas
        .where((v) => v.valorVenda > 2000)
        .length;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("SalesInsight"),
        centerTitle: true,
        actions: [Icon(Icons.search)],
      ),
      body: Column(
        children: [
          // 🔷 CARDS SUPERIORES
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                _card("Total de Produtos", totalProdutos.toString()),
                SizedBox(width: 8),
                _card(
                  "Receita Total",
                  "R\$ ${receitaTotal.toStringAsFixed(2)}",
                ),
                SizedBox(width: 8),
                _card("Vendas Premium", vendasPremium.toString()),
              ],
            ),
          ),

          // 🔽 FILTRO VISUAL
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text("Categoria: Eletrónicos"),
                SizedBox(width: 8),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),

          // 🔽 LISTA OU MENSAGEM (RN04)
          Expanded(
            child: vendasFiltradas.isEmpty
                ? Center(
                    child: Text(
                      "Nenhuma venda desta categoria encontrada.",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: vendasFiltradas.length,
                    itemBuilder: (context, index) {
                      final venda = vendasFiltradas[index];

                      bool premium = venda.valorVenda > 2000;

                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        padding: EdgeInsets.all(16),

                        // ✅ RN03 - ESTILO PROFISSIONAL
                        decoration: BoxDecoration(
                          color: premium ? Colors.red.shade100 : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                          border: Border(
                            left: BorderSide(
                              color: premium ? Colors.red : Colors.blue,
                              width: 5,
                            ),
                          ),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 🔹 INFO
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  venda.cliente,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Estoque: -- unidades",
                                ), // visual igual mock
                              ],
                            ),

                            // 🔹 VALOR + ÍCONE (RN02)
                            Row(
                              children: [
                                Text(
                                  "R\$ ${venda.valorVenda.toStringAsFixed(2)}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                if (premium)
                                  Icon(Icons.trending_up, color: Colors.orange),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // 🔶 LEGENDA
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _legenda(Colors.orange, "Pendente"),
                _legenda(Colors.blue, "Enviado"),
                _legenda(Colors.green, "Entregue"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔷 CARD
  Widget _card(String titulo, String valor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(titulo, style: TextStyle(fontSize: 11)),
            SizedBox(height: 6),
            Text(valor, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // 🔶 LEGENDA
  Widget _legenda(Color cor, String texto) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: cor),
        SizedBox(width: 5),
        Text(texto),
      ],
    );
  }
}
