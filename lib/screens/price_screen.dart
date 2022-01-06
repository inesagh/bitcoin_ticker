import 'package:bitcoin_ticker/components/crypto_card.dart';
import 'package:bitcoin_ticker/utilities/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();
  Map<String, String> ratesAndCurrencies = {};
  bool isWaiting = true;

  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: getDropdownItems(),
      onChanged: (value) async {
        setState(() {
          selectedCurrency = value!;
          print(selectedCurrency);
        });
        getRate();
      },
      dropdownColor: Colors.lightBlue,
      menuMaxHeight: 300,
      borderRadius: BorderRadius.circular(5),
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      onSelectedItemChanged: (int value) async {
        setState(() {
          selectedCurrency = currenciesList[value];
        });
        getRate();
      },
      itemExtent: 35,
      magnification: 1.19,
      children: getPickerItems(),
      looping: true,
      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
        background: Colors.transparent,
      ),
    );
  }

  void getRate() async {
    isWaiting = true;
    try {
      String rateByNowForBTC = await coinData.getRate('BTC', selectedCurrency);
      String rateByNowForETH = await coinData.getRate('ETH', selectedCurrency);
      String rateByNowForLTC = await coinData.getRate('LTC', selectedCurrency);
      isWaiting = false;
      setState(() {
        ratesAndCurrencies.putIfAbsent('BTC', () => rateByNowForBTC);
        ratesAndCurrencies.putIfAbsent('ETH', () => rateByNowForETH);
        ratesAndCurrencies.putIfAbsent('LTC', () => rateByNowForLTC);
      });
    } catch (e) {
      print(e);
    }
  }

  List<CryptoCard> makeCards(){
    List<CryptoCard> cryptos = [];
    ratesAndCurrencies.forEach((currency, rate) =>
        cryptos.add(CryptoCard(
            rate: isWaiting ? '?' : rate,
            selectedCurrency: selectedCurrency,
            cryptoCurrency: currency)));

    return cryptos;
  }

  @override
  void initState() {
    super.initState();
    getRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: makeCards()),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: !Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropdownItems() {
    return currenciesList
        .map((currency) => DropdownMenuItem(
      child: Text(currency),
      value: currency,
    ))
        .toList();
  }

  List<Text> getPickerItems() {
    return currenciesList
        .map((currency) => Text(
      currency,
      style: TextStyle(fontSize: 17, color: Colors.white),
    ))
        .toList();
  }

}
