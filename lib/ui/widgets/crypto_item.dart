import 'dart:math';
import 'package:flutter/material.dart';
import '../../model/crypto.dart';

class TextStyles {
  static TextStyle title = const TextStyle(
      fontFamily: 'SFProDisplay', fontWeight: FontWeight.w600, fontSize: 17);
}

class CryptoItem extends StatelessWidget {
  final Crypto crypto;

  const CryptoItem({super.key, required this.crypto});

  Color _generateColor(String symbol) {
    final hash = symbol.codeUnits.fold(0, (prev, elem) => prev + elem);
    final random = Random(hash);
    return Color.fromARGB(
      40,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = _generateColor(crypto.symbol);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(builder: (context, constraints) {
              final borderRadius = constraints.maxWidth * 0.32;

              return Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              );
            }),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              crypto.symbol,
              style: TextStyles.title,
            ),
          ),
          Text(
            '\$${crypto.priceUsd.toStringAsFixed(2)}',
            style: TextStyles.title,
          ),
        ],
      ),
    );
  }
}
