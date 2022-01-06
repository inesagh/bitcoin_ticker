import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  CryptoCard({
    required this.rate,
    required this.selectedCurrency,
    required this.cryptoCurrency
  });

  final String rate;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      color: Colors.lightBlueAccent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
        child: Text(
          '1 $cryptoCurrency = $rate $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
