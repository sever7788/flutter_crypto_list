import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/crypto_cubit.dart';
import 'services/crypto_service.dart';
import 'ui/crypto_list_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env"); // Загрузка переменных
  final token = dotenv.env['API_TOKEN'];
  final service = CryptoService(token);

  runApp(MyApp(service));
}

class MyApp extends StatelessWidget {
  final CryptoService service;

  const MyApp(this.service, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => CryptoCubit(service)..loadCryptos(),
        child: const CryptoListScreen(),
      ),
    );
  }
}
