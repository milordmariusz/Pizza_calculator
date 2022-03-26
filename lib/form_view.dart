import 'package:flutter/material.dart';

import 'details_view.dart';

class formView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');
  TextEditingController t3 = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _pizzaDiameter(),
                  const SizedBox(height: 20),
                  _crustWidth(),
                  const SizedBox(height: 20),
                  _price(),
                  const SizedBox(height: 20),
                  _calculateButton(context)
                ],
              ),
            )));
  }

  Widget _pizzaDiameter() {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.orange,
      controller: t1,
      decoration: InputDecoration(
          icon: Icon(Icons.local_pizza_outlined),
          hintText: 'Enter pizza diameter (cm)',
          labelText: 'Pizza',
          fillColor: Colors.orange,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter pizza diameter';
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
          hintText: 'Enter crust width (cm)',
          labelText: 'Crust',
          fillColor: Colors.orange,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter crust width';
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
                      )));
        }
      },
      child: Text('Calculate'),
    );
  }
}
