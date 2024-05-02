import 'package:flutter/material.dart';
import 'package:todos_mobiles/second.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MinhaPrimeiraTela(),
    );
  }
}

// Código anterior omitido

class MinhaPrimeiraTela extends StatelessWidget {
  const MinhaPrimeiraTela({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Minha primeira tela'),
      ),
      body: Column(
        children:  <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network('https://images.pexels.com/photos/8364804/pexels-photo-8364804.jpeg',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/cao.jpg',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          ElevatedButton(onPressed: 
          (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MinhaSegundaTela()));
          }, child: Text("Mudar de Tela")),
        ],
      )
    );
  }
}