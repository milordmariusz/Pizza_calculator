import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_calculator/user_preferences.dart';

import 'details_view.dart';

class FormView extends StatefulWidget {
  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController diameterController = TextEditingController(text: '');
  TextEditingController crustController = TextEditingController(text: '');
  TextEditingController priceController = TextEditingController(text: '');
  String userCurrency = "";

  String radioButtonItem = 'Analysis';

  int id = 1;

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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
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
      controller: diameterController,
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
        } else if (double.tryParse(diameterController.text)==null) {
          return 'Invalid data';
        } else if (double.tryParse(crustController.text)!=null) {
          if (double.parse(diameterController.text.replaceAll(",", ".")) <=
              double.parse(crustController.text.replaceAll(",", "."))) {
            return 'Pizza can\'t be smaller than crust';
          }
        }
        return null;
      },
    );
  }

  Widget _crustWidth() {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.orange,
      controller: crustController,
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
        } else if (double.tryParse(crustController.text)==null) {
          return 'Invalid data';
        } else if (double.tryParse(diameterController.text)!=null) {
          if (double.parse(diameterController.text.replaceAll(",", ".")) <=
              double.parse(crustController.text.replaceAll(",", "."))) {
            return 'Pizza can\'t be smaller than crust';
          }
        }
        return null;
      },
    );
  }

  Widget _price() {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.orange,
      controller: priceController,
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
        } else if (double.tryParse(value)==null) {
          return 'Invalid data';
        }
        return null;
      },
    );
  }

  Widget _calculateButton(BuildContext context) {
    return Container(
      height: 50,
      width: 140,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            FocusScope.of(context).unfocus();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => detailsView(
                          pizza: double.parse(
                              diameterController.text.replaceAll(",", ".")),
                          crust: double.parse(
                              crustController.text.replaceAll(",", ".")),
                          price: double.parse(
                              priceController.text.replaceAll(",", ".")),
                          currency: userCurrency,
                        )));
          }
        },
        child: Text('Calculate',
            style:
                GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
