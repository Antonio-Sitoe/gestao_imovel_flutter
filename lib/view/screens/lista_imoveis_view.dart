import 'package:flutter/material.dart';
import 'package:imovel/models/novo.dart';
import 'package:imovel/models/velho.dart';
import 'package:imovel/view/models/imovel_view_models.dart';
import 'package:provider/provider.dart';

class ListaImoveisView extends StatelessWidget {
  const ListaImoveisView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ImovelViewModels>();
    final imoveis = viewModel.imoveis;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Imóveis Cadastrados'),
        actions: [
          PopupMenuButton<TipoImovel?>(
            onSelected: (filtro) => viewModel.definirFiltro(filtro),
            itemBuilder:
                (_) => [
                  const PopupMenuItem(value: null, child: Text("Todos")),
                  const PopupMenuItem(
                    value: TipoImovel.novo,
                    child: Text("Novos"),
                  ),
                  const PopupMenuItem(
                    value: TipoImovel.velho,
                    child: Text("Velhos"),
                  ),
                ],
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body:
          imoveis.isEmpty
              ? const Center(child: Text('Nenhum imóvel encontrado.'))
              : ListView.builder(
                itemCount: imoveis.length,
                itemBuilder: (context, index) {
                  final imovel = imoveis[index];
                  final tipo =
                      imovel is Novo
                          ? 'Novo - +${imovel.adicional}'
                          : imovel is Velho
                          ? 'Velho - -${imovel.desconto}'
                          : 'Desconhecido';

                  final precoFinal =
                      imovel is Novo
                          ? imovel.precoFinal
                          : imovel is Velho
                          ? imovel.precoFinal
                          : imovel.preco;

                  return ListTile(
                    title: Text(imovel.endereco),
                    subtitle: Text(
                      '$tipo\nPreço final: \$${precoFinal.toStringAsFixed(2)}',
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Aqui você pode navegar para um formulário de edição
                            // Passar o index e os dados do imóvel
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            viewModel.remover(imovel);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Imóvel removido.')),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
