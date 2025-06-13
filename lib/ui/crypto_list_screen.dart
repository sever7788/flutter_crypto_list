import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/crypto_cubit.dart';
import 'widgets/crypto_item.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  _CryptoListScreenState createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        context.read<CryptoCubit>().loadCryptos();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _getItemHeight(double maxHeight) {
    final padding = MediaQuery.of(context).padding;
    final heightWithoutStatusBar = maxHeight - padding.top;
    return heightWithoutStatusBar / 9;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CryptoCubit, CryptoState>(
        builder: (context, state) {
          if (state is CryptoLoaded) {
            return LayoutBuilder(builder: (context, constraints) {
              return ListView.builder(
                controller: _controller,
                itemCount: state.cryptos.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                      height: _getItemHeight(constraints.maxHeight),
                      child: CryptoItem(crypto: state.cryptos[index]));
                },
              );
            });
          } else if (state is CryptoError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
