class Crypto {
  final String symbol;
  final double priceUsd;

  Crypto({required this.symbol, required this.priceUsd});

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      symbol: json['symbol'] as String,
      priceUsd: double.tryParse(json['priceUsd'] as String) ?? 0.0,
    );
  }
}