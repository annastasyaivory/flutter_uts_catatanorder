import 'package:flutter_uts_catatanorder/pages/customer.dart';
import 'package:flutter_uts_catatanorder/pages/transaksi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Catatan Orderan'),
        backgroundColor: Colors.blueGrey[200],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 60,
            width: 120,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                color: Colors.green),
            child: RaisedButton(
              child: Text("Customer",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Customer()),
                );
              },
            ),
          ),
          Container(
            height: 60,
            width: 120,
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text("Transaksi",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Transaksi()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // BoxDecoration buildBoxDecoration() {
  //   return BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(12)),
  //       gradient: LinearGradient(
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //         //jumlah stop berbanding lurus dengan jumlah warna
  //         stops: [0.3, 0.6, 0.9],
  //         colors: [
  //           Color.fromRGBO(255, 105, 180, 1), //red-green-blue-o
  //           Color.fromRGBO(255, 182, 193, 1),
  //           Color.fromRGBO(255, 192, 203, 1),
  //         ],
  //       ),
  //       boxShadow: []);
  // }
}
