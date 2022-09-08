import 'package:bitcoin_ticker/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bitcoin_ticker/networking.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String selectedCrypto = 'BTC';
  String selectedCurrency = 'INR';

  void getInitData() async {
    var cryptoData = await CryptoPriceModel()
        .getCryptoData(selectedCrypto, selectedCurrency);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PriceScreen(
          initData: cryptoData,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getInitData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitWanderingCubes(
        color: Colors.deepPurpleAccent,
      ),
    );
  }
}
