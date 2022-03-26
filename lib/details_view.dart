import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class detailsView extends StatelessWidget {
  detailsView(
      {Key? key, required this.pizza, required this.crust, required this.price})
      : super(key: key);

  double pizza;
  double crust;
  double price;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
          children: [
            Center(
                child:
                    Icon(Icons.local_pizza_outlined, size: size.width / 1.5)),
            SizedBox(height: size.height / 20),
            Text(
              "Your Pizza Analysis",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height / 30),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Pizza diameter:  ",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              TextSpan(
                  text: pizza.toStringAsFixed(1),
                  style: TextStyle(fontSize: 20, color: Colors.orange)),
            ])),
            SizedBox(height: size.height / 30),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Crust width:  ",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              TextSpan(
                  text: crust.toStringAsFixed(1),
                  style: TextStyle(fontSize: 20, color: Colors.orange)),
            ])),
            SizedBox(height: size.height / 30),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Price:  ",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              TextSpan(
                  text: price.toStringAsFixed(1),
                  style: TextStyle(fontSize: 20, color: Colors.orange)),
            ])),
            SizedBox(height: size.height / 30),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Pizza field:  ",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              TextSpan(
                  text: (3.14 * pow(pizza / 2, 2)).toStringAsFixed(1) +
                      " cm\u00B2",
                  style: TextStyle(fontSize: 20, color: Colors.orange)),
            ])),
            SizedBox(height: size.height / 30),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Pizza field (no crust):  ",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              TextSpan(
                  text:
                      (3.14 * pow((pizza - crust) / 2, 2)).toStringAsFixed(1) +
                          " cm\u00B2",
                  style: TextStyle(fontSize: 20, color: Colors.orange)),
            ])),
            SizedBox(height: size.height / 30),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Crust field:  ",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              TextSpan(
                  text: (3.14 * pow(pizza / 2, 2) -
                              (3.14 * pow((pizza - crust) / 2, 2)))
                          .toStringAsFixed(1) +
                      " cm\u00B2",
                  style: TextStyle(fontSize: 20, color: Colors.orange)),
            ])),
            SizedBox(height: size.height / 30),
            RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Crust field:  ",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  TextSpan(
                      text: (3.14 * pow(pizza / 2, 2) -
                          (3.14 * pow((pizza - crust) / 2, 2)))
                          .toStringAsFixed(1) +
                          " cm\u00B2",
                      style: TextStyle(fontSize: 20, color: Colors.orange)),
                ])),
          ],
        ));
  }
}
