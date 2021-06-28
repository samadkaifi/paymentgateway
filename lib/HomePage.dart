import 'dart:convert';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:payment_gateway/data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  payment() async {
    String orderid = 'OrderId1234';
    http.Response res = await http.post(
        Uri.parse(
          'https://test.cashfree.com/api/v2/cftoken/order',
        ),
        headers: {
          'x-client-id': AppId,
          'x-client-secret': AppSecret,
        },
        body: json.encode({
          'orderId': orderid,
          'orderAmount': '1',
          'orderCurrency': 'INR',
        }));
    if (res.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);
      String token = ['cftoken'].toString();
      Map<String, dynamic> param = {
        'tokenData': map['cftoken'],
        'stage': 'TEST',
        'appId': AppId,
        'orderId': orderid,
        'orderAmount': '1',
        'customerName': 'TestSubject',
        'customerPhone': '9876543210',
        'customerEmail': 'testsubject@gmail.com',
        'hideOrderId': false,
        'orderCurrency': 'INR',
      };
      CashfreePGSDK.doPayment(param)
          .then((value) => value?.forEach((key, value) {
                print('$key,$value');
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0x00000000),
        centerTitle: true,
        title: Text(
          'PaymentGateway',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                payment();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.yellow, Colors.red],
                  ),
                ),
                height: deviceWidth * .15,
                width: deviceWidth * .5,
                child: Center(
                  child: Text(
                    'PAYMENT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
