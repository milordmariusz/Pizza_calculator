import 'dart:math';

import 'package:flutter/material.dart';

class detailsView extends StatelessWidget {
  detailsView(
      {Key? key, required this.pizza, required this.crust, required this.price})
      : super(key: key);

  double pizza;
  double crust;
  double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Pizza field: " + ((3.14 * pow(pizza/2,2)).toString()))
        ],
      ),
    );
  }
}
