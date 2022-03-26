import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:pizza_calculator/user_preferences.dart';

import 'details_view.dart';

class formView extends StatefulWidget {
  @override
  _formViewState createState() => _formViewState();
}

class _formViewState extends State<formView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');
  TextEditingController t3 = TextEditingController(text: '');
  //TextEditingController t4 = TextEditingController(text: '');
  String userCurrency = "";

  @override
  void initState() {
    super.initState();

    userCurrency = UserPreferences.getCurrency() ?? "\u{20AC}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _currencyRow(),
                      const SizedBox(height: 20),
                      _pizzaDiameter(),
                      const SizedBox(height: 20),
                      _crustWidth(),
                      const SizedBox(height: 20),
                      _price(),
                      const SizedBox(height: 20),
                      // _currency(),
                      // const SizedBox(height: 20),
                      _calculateButton(context),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget _currencyRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Currency: "),
        ElevatedButton(
            onPressed: () {
              showCurrencyPicker(
                context: context,
                showFlag: true,
                showCurrencyName: true,
                showCurrencyCode: true,
                onSelect: (Currency currency) async {
                    userCurrency = currency.symbol;
                    await UserPreferences.setCurrency(userCurrency);
                    setState(() {});
                },
                favorite: ['PLN'],
              );
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
                side: BorderSide(
                  width: 1.0,
                  color: Colors.grey,
                )),
            child: Text(userCurrency))
      ],
    );
  }

  Widget _pizzaDiameter() {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.orange,
      controller: t1,
      decoration: InputDecoration(
          icon: Icon(Icons.local_pizza_outlined),
          suffixText: "cm",
          hintText: 'Enter pizza diameter (cm)',
          labelText: 'Pizza',
          fillColor: Colors.orange,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter pizza diameter';
        } else if (double.parse(t1.text.replaceAll(",", ".")) <
            double.parse(t2.text.replaceAll(",", "."))) {
          return 'Pizza can\'t be smaller than crust';
        } else if (value.contains('-') ||
            value.contains(' ') ||
            (value.indexOf('.') != value.lastIndexOf('.')) ||
            (value.indexOf(',') != value.lastIndexOf(',')) ||
            (value.contains('.') && (value.contains(',')))) {
          return 'Invalid data';
        }
        return null;
      },
    );
  }

  Widget _crustWidth() {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.orange,
      controller: t2,
      decoration: InputDecoration(
          icon: Icon(Icons.local_pizza),
          suffixText: "cm",
          hintText: 'Enter crust width (cm)',
          labelText: 'Crust',
          fillColor: Colors.orange,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter crust width';
        } else if (double.parse(t1.text.replaceAll(",", ".")) <
            double.parse(t2.text.replaceAll(",", "."))) {
          return 'Pizza can\'t be smaller than crust';
        } else if (value.contains('-') ||
            value.contains(' ') ||
            (value.indexOf('.') != value.lastIndexOf('.')) ||
            (value.indexOf(',') != value.lastIndexOf(',')) ||
            (value.contains('.') && (value.contains(',')))) {
          return 'Invalid data';
        }
        return null;
      },
    );
  }

  Widget _price() {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.orange,
      controller: t3,
      decoration: InputDecoration(
          icon: Icon(Icons.monetization_on_outlined),
          suffixText: userCurrency,
          hintText: 'Enter pizza price',
          labelText: 'Price',
          fillColor: Colors.orange,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter price';
        } else if (value.contains('-') ||
            value.contains(' ') ||
            (value.indexOf('.') != value.lastIndexOf('.')) ||
            (value.indexOf(',') != value.lastIndexOf(',')) ||
            (value.contains('.') && (value.contains(',')))) {
          return 'Invalid data';
        }
        return null;
      },
    );
  }

  // Widget _currency() {
  //   return TextFormField(
  //     keyboardType: TextInputType.text,
  //     maxLength: 3,
  //     cursorColor: Colors.orange,
  //     controller: t4,
  //     decoration: InputDecoration(
  //         icon: Icon(Icons.monetization_on_rounded),
  //         hintText: 'Enter currency',
  //         labelText: 'Currency',
  //         fillColor: Colors.orange,
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter currency';
  //       } else if (value.contains('-') ||
  //           value.contains(' ') ||
  //           (value.indexOf('.') != value.lastIndexOf('.')) ||
  //           (value.indexOf(',') != value.lastIndexOf(',')) ||
  //           (value.contains('.') && (value.contains(',')))) {
  //         return 'Invalid data';
  //       }
  //       return null;
  //     },
  //   );
  // }

  Widget _calculateButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => detailsView(
                        pizza: double.parse(t1.text.replaceAll(",", ".")),
                        crust: double.parse(t2.text.replaceAll(",", ".")),
                        price: double.parse(t3.text.replaceAll(",", ".")),
                        currency: userCurrency,
                      )));
        }
      },
      child: Text('Calculate'),
    );
  }
}
