import 'package:bitcoin_ticker/screens/price_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BitcoinTicker());
}

class BitcoinTicker extends StatelessWidget {
  const BitcoinTicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.light(),
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.lightBlue),
      ),
      home: PriceScreen(),
    );
  }
}
