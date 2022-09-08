import 'package:bitcoin_ticker/networking.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key, this.initData}) : super(key: key);

  final initData;

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'INR';
  String selectedCrypto = 'BTC';
  CryptoPriceModel cryptoPriceModel = CryptoPriceModel();
  String cryptoPrice = '1.0';
  var cryptoData;

  List<DropdownMenuItem<String>> getDropdownCurrencies() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  List<DropdownMenuItem<String>> getDropdownCrypto() {
    List<DropdownMenuItem<String>> dropdownCryptoItems = [];

    for (String crypto in cryptoList) {
      var newCrypto = DropdownMenuItem(child: Text(crypto), value: crypto);

      dropdownCryptoItems.add(newCrypto);
    }

    return dropdownCryptoItems;
  }

  void updateUI(cryptoData) {
    setState(() {
      double price = cryptoData['rate'];
      cryptoPrice = price.toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    updateUI(widget.initData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bitcoin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.deepPurpleAccent,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          Text(
                            'Select Cryptocurrency',
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 150,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            color: Colors.deepPurpleAccent,
                            child: DropdownButton<String>(
                              iconSize: 50,
                              value: selectedCrypto,
                              items: getDropdownCrypto(),
                              onChanged: (value) {
                                setState(() async {
                                  selectedCrypto = value!;
                                  cryptoData =
                                      await cryptoPriceModel.getCryptoData(
                                          selectedCrypto, selectedCurrency);
                                  updateUI(cryptoData);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.deepPurpleAccent,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          Text(
                            'Select Currency',
                            style: TextStyle(fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 150,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            color: Colors.deepPurpleAccent,
                            child: DropdownButton<String>(
                              iconSize: 50,
                              value: selectedCurrency,
                              items: getDropdownCurrencies(),
                              onChanged: (value) {
                                setState(() async {
                                  selectedCurrency = value!;
                                  cryptoData =
                                      await cryptoPriceModel.getCryptoData(
                                          selectedCrypto, selectedCurrency);
                                  updateUI(cryptoData);
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.deepPurpleAccent,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          Text(
                            '1 $selectedCrypto = $cryptoPrice $selectedCurrency',
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
