import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/crypto.dart';
import '../services/crypto_service.dart';

part 'crypto_state.dart';

class CryptoCubit extends Cubit<CryptoState> {
  final CryptoService _service;
  int _currentPage = 0;
  bool _isLoading = false;

  CryptoCubit(this._service) : super(CryptoInitial());

  void loadCryptos() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      List<Crypto> cryptos = [];
      final newItems = await _service.fetchCryptos(_currentPage);
      _currentPage++;
      if (state is CryptoLoaded) {
        cryptos = List.from((state as CryptoLoaded).cryptos);
      }
      cryptos.addAll(newItems);
      emit(CryptoLoaded(List.from(cryptos)));
    } catch (e) {
      emit(CryptoError('Ошибка загрузки: ${e.toString()}'));
    } finally {
      _isLoading = false;
    }
  }
}
