import 'package:flutter/material.dart';
import 'package:imovel/view/models/imovel_view_models.dart';
import 'package:imovel/view/screens/form_imovel_view.dart';
import 'package:imovel/view/screens/lista_imoveis_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ImovelViewModels(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestão de Imóveis',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestão de Imóveis')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Cadastrar Imóvel'),
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FormImovelView()),
                  ),
            ),
            ElevatedButton(
              child: const Text('Ver Lista de Imóveis'),
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ListaImoveisView()),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
