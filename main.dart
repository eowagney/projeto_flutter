import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaPersonagem(),
    );
  }
}

class Personagem {
  String nome;
  String classe;
  int nivel;
  double vida;

  // Construtor nomeado
  Personagem.novo({
    required this.nome,
    required this.classe,
    required this.nivel,
    required this.vida,
  });

  // Factory
  factory Personagem.fromMap(Map<String, dynamic> map) {
    return Personagem.novo(
      nome: map['nome'],
      classe: map['classe'],
      nivel: map['nivel'],
      vida: map['vida'],
    );
  }
}

Personagem gerarPersonagem() {
  final random = Random();

  List nomes = ["Arthas", "Luna", "Draven", "Kael"];
  List classes = ["Guerreiro", "Mago", "Arqueiro"];

  Map<String, dynamic> dados = {
    "nome": nomes[random.nextInt(nomes.length)],
    "classe": classes[random.nextInt(classes.length)],
    "nivel": random.nextInt(50) + 1,
    "vida": random.nextDouble() * 100
  };

  return Personagem.fromMap(dados);
}

class TelaPersonagem extends StatefulWidget {
  @override
  _TelaPersonagemState createState() => _TelaPersonagemState();
}

class _TelaPersonagemState extends State<TelaPersonagem> {

  Personagem? personagem;

  @override
  Widget build(BuildContext context) {

    Color corBorda = Colors.blue;

    if (personagem != null && personagem!.vida < 20) {
      corBorda = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Card RPG"),
      ),
      body: Center(
        child: personagem == null
            ? Text("Clique no botão para gerar um personagem")
            : Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: corBorda,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Nome: ${personagem!.nome}",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text("Classe: ${personagem!.classe}"),
                    Text("Nível: ${personagem!.nivel}"),
                    Text(
                      "Vida: ${personagem!.vida.toStringAsFixed(1)}",
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.casino),
        onPressed: () {
          setState(() {
            personagem = gerarPersonagem();
          });
        },
      ),
    );
  }
}