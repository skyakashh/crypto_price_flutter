import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dropDown.dart';
import 'coin_data.dart';
import 'package:http/http.dart';
import 'dart:convert';



class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

String cryp_name='BTC';
int cryp_price=0;
String init = 'Enter the crypro-currency name';
String final_currency='INR';
String to_disp='0 BTC = 0 INR';

Future getentered_price(String name) async
{
  Response response = await
  get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/$name/${final_currency}?apikey=$apikey'));
  var data=jsonDecode(response.body);
  if(data==null)
  {
    cryp_price=0;
  }
  else {
    var p = data['rate'];
    print(p);
    cryp_price=p.toInt();
    to_disp='1 $cryp_name = $cryp_price $final_currency';
  }
}

class _PriceScreenState extends State<PriceScreen> {
  int j=0;
  String selecetedCurrency = 'INR';
  dropDown dropdown=dropDown();
  int price =0,price_e=0,price_l=0;
  String showcurrency='INR';

  Future <void> getPrice(String currency) async
  {
      Response response = await
      get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apikey=$apikey'));
      var data=jsonDecode(response.body);
      if(data==null)
        {
          price=0;
        }
      else {
         var p = data['rate'];
         price=p.toInt();
      }
  }

  Future getPrice_e(String currency) async
  {
    Response response = await
    get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/ETH/$currency?apikey=$apikey'));
    var data=jsonDecode(response.body);
    if(data==null)
    {
      price_e=0;
    }
    else {
      var p = data['rate'];
      price_e=p.toInt();
    }
  }

  Future <void> getPrice_l(String currency) async
  {
    Response response = await
    get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/LTC/$currency?apikey=$apikey'));
    var data=jsonDecode(response.body);
    if(data==null)
    {
      price_l=0;
    }
    else {
      var p = data['rate'];
      price_l=p.toInt();
    }
  }


  CupertinoPicker scrollThrough(){
    List < Widget> dropItems = [];
    for(int i=0;i<currenciesList.length;i++)
    {
      var item = Text('${currenciesList[i]}');
      dropItems.add(item);
    }
    return  CupertinoPicker(
      onSelectedItemChanged: (selectedIndex)
      {
        setState(() {
          getPrice(currenciesList[selectedIndex]);
          getPrice_e(currenciesList[selectedIndex]);
          getPrice_l(currenciesList[selectedIndex]);
          showcurrency=currenciesList[selectedIndex];
          final_currency=currenciesList[selectedIndex];
        });
        },
      itemExtent: 40.0,
      children: dropItems,
    );
  }


  DropdownButton<String> getDropButton(){
    List <DropdownMenuItem <String> > dropItems = [];
    for(int i=0;i<currenciesList.length;i++)
    {
      var item = DropdownMenuItem(
        child: Text('${currenciesList[i]}'),
        value: '${currenciesList[i]}',
      );
      dropItems.add(item);
    }
    return DropdownButton<String>(items: dropItems,
              style: TextStyle(color: Colors.white),
              value: selecetedCurrency,
              onChanged: (value) {
                setState(() {
                  selecetedCurrency = value.toString();
                  getPrice(selecetedCurrency);
                  getPrice_e(selecetedCurrency);
                  getPrice_l(selecetedCurrency);
                  showcurrency=selecetedCurrency;
                  final_currency=selecetedCurrency;
                });
              },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $price $showcurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $price_e $showcurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $price_l $showcurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 9,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                      child: Card(
                        color: Colors.lightBlueAccent,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              icon: Icon(Icons.attach_money, color: Colors.white,),
                              //if (cryp_price==0)
                              hintText: init,
                              //else hintText: '1 $cryp_name = $cryp_price $final_currency',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value){
                              //setState(() {
                                cryp_name = value;
                              //});
                            },
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '1 $cryp_name = $cryp_price $final_currency',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
             Expanded(
               flex: 1,
               child:  FlatButton(
                color: Colors.lightBlueAccent,
               onPressed: (){
                 setState(() {
                   getentered_price(cryp_name);
                   //if(cryp_price!=0)
                     //to_disp='1 $cryp_name = $cryp_price $final_currency';
                   });
                 },

                child: Icon(Icons.search),
                ),
             ),
            ],
          ),
          SizedBox(
            height: Platform.isIOS ? 295.0 : 269.6,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? scrollThrough() : getDropButton() ,
          ),
        ],
      ),
    );
  }
}

