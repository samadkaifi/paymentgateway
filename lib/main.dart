import 'package:flutter/material.dart';

import 'HomePage.dart';

void main() {
  runApp(PaymentGateway());
}

class PaymentGateway extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
