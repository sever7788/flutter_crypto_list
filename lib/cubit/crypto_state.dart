
part of 'crypto_cubit.dart';

abstract class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final List<Crypto> cryptos;
  CryptoLoaded(this.cryptos);
}

class CryptoError extends CryptoState {
  final String message;
  CryptoError(this.message);
}
