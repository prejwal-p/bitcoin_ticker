import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = '8F79E04E-274D-4C7D-8B2A-A9C15EE0EBA9';

class CryptoPriceModel {
  Future<dynamic> getCryptoData(String crypto, String currency) async {
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$apiKey'));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      return print(response.statusCode);
    }
  }
}
