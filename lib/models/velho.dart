import 'package:imovel/models/imovel.dart';

class Velho extends Imovel {
  double desconto;
  Velho({required String endereco, required preco, required this.desconto})
    : super(endereco: endereco, preco: preco);

  double get precoFinal => preco - desconto;

  @override
  String toString() {
    return 'Imóvel Velho - Endereço: $endereco, Preço Base: $preco, Desconto: $desconto, Preço Final: $precoFinal';
  }
}
