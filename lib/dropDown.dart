import 'package:flutter/material.dart';
import 'coin_data.dart';

class dropDown{

  String selecetedCurrency = 'INR';

  Widget menu(){
    return
    DropdownButton<String>(items: [
      DropdownMenuItem(
        child: Text('USD'),
        value: 'USD',
      ),
      DropdownMenuItem(
        child: Text('EUR'),
        value: 'EUR',
      ),
      DropdownMenuItem(
        child: Text('INR'),
        value: 'INR',
      ),
    ],
      style: TextStyle(color: Colors.white),
      value: selecetedCurrency,
      onChanged: (value) {
        // setState(() {
        //   selecetedCurrency = value.toString();
        // });
      },
    );
  }
}