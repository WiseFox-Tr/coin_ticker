import 'package:bitcoin_ticker/model/CryptoCurrency.dart';
import 'package:bitcoin_ticker/model/CryptoRatio.dart';
import 'package:bitcoin_ticker/services/privateKey.dart';
import 'HttpRequest.dart';

class WebServices {

  static const String baseURL = 'https://min-api.cryptocompare.com/data/pricemulti';
  static const String apiKey = privateKey;

  static Future<List<CryptoRatio>> getCryptoRate(List<CryptoCurrency> cryptoCurrencies, List<String> fiatCurrencies) async {

    String cryptoCurrenciesAsString = '';
    String fiatCurrenciesAsString = '';
    cryptoCurrencies.forEach((crypto) => cryptoCurrenciesAsString += '${crypto.name},');
    fiatCurrencies.forEach((fiat) => fiatCurrenciesAsString += '$fiat,');

    // url example : https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH&tsyms=USD,EUR&api_key={privateKey}
    Uri url = Uri.parse('$baseURL?fsyms=$cryptoCurrenciesAsString&tsyms=$fiatCurrenciesAsString&api_key=$apiKey');
    dynamic data = await HttpRequest.httpRequestGet(url);

    List<CryptoRatio> cryptoRatioList = [];
    cryptoCurrencies.forEach((crypto) {
      fiatCurrencies.forEach((fiat) {
        cryptoRatioList.add(CryptoRatio(crypto.name, fiat, data[crypto.name][fiat].toDouble()));
      });
    });
    return cryptoRatioList;
  }
}