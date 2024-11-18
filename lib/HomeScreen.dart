import 'package:flutter/material.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _amountController = TextEditingController();
  String fromCurrency = 'USD';
  String toCurrency = 'PKR';
  double convertedAmount = 0.0;

  // Predefined exchange rates (simplified version)
  final Map<String, double> exchangeRates = {
    'USD': 1.0, // Base currency
    'EUR': 0.85,
    'GBP': 0.75,
    'PKR': 285.0, // Example rate: 1 USD = 285 PKR
  };

  // Convert the amount based on the selected currencies
  void convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount > 0) {
      setState(() {
        convertedAmount = amount *
            (exchangeRates[toCurrency]! / exchangeRates[fromCurrency]!);
      });
    } else {
      setState(() {
        convertedAmount = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent.withOpacity(0.8),
          title: Text(
            'Currency Converter',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Stack(children: [
            Container(
              height: 800,
              width: 450,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/assets/Background.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60, top: 160),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Amount Input Field
                  TextField(
                    controller: _amountController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.pink.withOpacity(0.5),
                      labelText: 'Enter Amount',
                      labelStyle: TextStyle(fontSize: 23, color: Colors.black),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                    ),
                  ),
                  SizedBox(height: 20),

                  // From Currency Dropdown
                  DropdownButton<String>(
                    value: fromCurrency,
                    onChanged: (newValue) {
                      setState(() {
                        fromCurrency = newValue!;
                      });
                    },
                    items: ['USD', 'EUR', 'GBP', 'PKR']
                        .map((currency) => DropdownMenuItem<String>(
                              value: currency,
                              child: Text(
                                currency,
                                style: TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 10),

                  // To Currency Dropdown
                  DropdownButton<String>(
                    value: toCurrency,
                    onChanged: (newValue) {
                      setState(() {
                        toCurrency = newValue!;
                      });
                    },
                    items: ['USD', 'EUR', 'GBP', 'PKR']
                        .map((currency) => DropdownMenuItem<String>(
                              value: currency,
                              child: Text(
                                currency,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 20),

                  // Convert Button
                  ElevatedButton(
                    onPressed: convertCurrency,
                    child: Text(
                      'Convert',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Display Converted Amount
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    height: 100,
                    width: 400,
                    child: Text(
                      ' Amount: ${convertedAmount.toStringAsFixed(2)} $toCurrency',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
