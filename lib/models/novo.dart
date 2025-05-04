import 'package:imovel/models/imovel.dart';

class Novo extends Imovel {
  final double adicional;
  Novo({
    required String endereco,
    required double preco,
    required this.adicional,
  }) : super(endereco: endereco, preco: preco);

  double get precoFinal => preco + adicional;

  @override
  String toString() {
    return 'Imóvel Novo - Endereço: $endereco, Preço Base: $preco, Adicional: $adicional, Preço Final: $precoFinal';
  }
}
