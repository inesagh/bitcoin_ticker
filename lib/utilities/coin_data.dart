import 'package:bitcoin_ticker/services/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const baseAPIOfCoin = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'YOUR-API-KEY';

class CoinData {
  Future<String> getRate(String from, String to) async {
    Networking networking =
        Networking('$baseAPIOfCoin/$from/$to?apikey=$apiKey');
    var data = await networking.getData();
    double rate = data['rate'];

    return rate.toStringAsFixed(0);
  }
}
