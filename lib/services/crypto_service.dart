import 'package:dio/dio.dart';
import '../model/crypto.dart';

class CryptoService {
  final Dio _dio;

  CryptoService(String? token)
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://rest.coincap.io/v3',
            headers: {'Authorization': 'Bearer $token'},
          ),
        );

  Future<List<Crypto>> fetchCryptos(int page) async {
    const limit = 15;
    final response = await _dio.get('/assets', queryParameters: {
      'limit': limit,
      'offset': page * limit,
    });
    final data = response.data['data'] as List;
    return data.map((e) => Crypto.fromJson(e)).toList();
  }
}
