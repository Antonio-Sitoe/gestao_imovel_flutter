import 'package:flutter/material.dart';
import 'package:imovel/models/novo.dart';
import 'package:imovel/models/velho.dart';
import 'package:imovel/view/models/imovel_view_models.dart';
import 'package:provider/provider.dart';

enum TipoImovel { novo, velho }

class FormImovelView extends StatefulWidget {
  const FormImovelView({super.key});

  @override
  State<FormImovelView> createState() => _FormImovelViewState();
}

class _FormImovelViewState extends State<FormImovelView> {
  final enderecoController = TextEditingController();
  final precoController = TextEditingController();
  final adicionalController = TextEditingController();
  final descontoController = TextEditingController();

  TipoImovel? tipoSelecionado;

  void limparCampos() {
    enderecoController.clear();
    precoController.clear();
    adicionalController.clear();
    descontoController.clear();
    setState(() {
      tipoSelecionado = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ImovelViewModels>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Imóvel')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: enderecoController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: precoController,
              decoration: const InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: tipoSelecionado == TipoImovel.novo,
                  onChanged: (val) {
                    setState(() {
                      tipoSelecionado = val! ? TipoImovel.novo : null;
                    });
                  },
                ),
                const Text('Novo'),
                const SizedBox(width: 20),
                Checkbox(
                  value: tipoSelecionado == TipoImovel.velho,
                  onChanged: (val) {
                    setState(() {
                      tipoSelecionado = val! ? TipoImovel.velho : null;
                    });
                  },
                ),
                const Text('Velho'),
              ],
            ),
            if (tipoSelecionado == TipoImovel.novo)
              TextField(
                controller: adicionalController,
                decoration: const InputDecoration(labelText: 'Adicional'),
                keyboardType: TextInputType.number,
              ),
            if (tipoSelecionado == TipoImovel.velho)
              TextField(
                controller: descontoController,
                decoration: const InputDecoration(labelText: 'Desconto'),
                keyboardType: TextInputType.number,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final preco = double.tryParse(precoController.text) ?? 0;
                final endereco = enderecoController.text;

                if (tipoSelecionado == TipoImovel.novo) {
                  final adicional =
                      double.tryParse(adicionalController.text) ?? 0;
                  viewModel.adicionar(
                    Novo(
                      endereco: endereco,
                      preco: preco,
                      adicional: adicional,
                    ),
                  );
                } else if (tipoSelecionado == TipoImovel.velho) {
                  final desconto =
                      double.tryParse(descontoController.text) ?? 0;
                  viewModel.adicionar(
                    Velho(endereco: endereco, preco: preco, desconto: desconto),
                  );
                }

                limparCampos();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Imóvel cadastrado!')),
                );
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
