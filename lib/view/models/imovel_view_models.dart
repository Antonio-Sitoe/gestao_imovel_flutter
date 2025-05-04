import 'package:flutter/foundation.dart';
import 'package:imovel/models/imovel.dart';
import 'package:imovel/models/novo.dart';
import 'package:imovel/models/velho.dart';

enum TipoImovel { novo, velho }

class ImovelViewModels extends ChangeNotifier {
  final List<Imovel> _imoveis = [];
  TipoImovel? filtro;

  List<Imovel> get imoveis {
    if (filtro == TipoImovel.novo) {
      return _imoveis.where((i) => i is Novo).toList();
    } else if (filtro == TipoImovel.velho) {
      return _imoveis.where((i) => i is Velho).toList();
    }
    return _imoveis;
  }

  void adicionar(Imovel imovel) {
    _imoveis.add(imovel);
    notifyListeners();
  }

  void remover(Imovel imovel) {
    _imoveis.remove(imovel);
    notifyListeners();
  }

  void atualizar(int index, Imovel novoImovel) {
    _imoveis[index] = novoImovel;
    notifyListeners();
  }

  void definirFiltro(TipoImovel? tipo) {
    filtro = tipo;
    notifyListeners();
  }
}
