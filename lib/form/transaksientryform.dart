import 'package:flutter_uts_catatanorder/models/transaksiItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransaksiEntryForm extends StatefulWidget {
  final TransaksiItem transaksiItem;
  TransaksiEntryForm(this.transaksiItem);
  @override
  TransaksiEntryFormState createState() =>
      TransaksiEntryFormState(this.transaksiItem);
}

class TransaksiEntryFormState extends State<TransaksiEntryForm> {
  TransaksiItem transaksiItem;
  TransaksiEntryFormState(this.transaksiItem);
  TextEditingController totalHargaController = TextEditingController();
  TextEditingController metodePembayaranController = TextEditingController();
  TextEditingController ekspedisiController = TextEditingController();
  TextEditingController statusPembayaranController = TextEditingController();
  TextEditingController customerIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (transaksiItem != null) {
      totalHargaController.text = transaksiItem.totalHarga;
      metodePembayaranController.text = transaksiItem.metodePembayaran;
      ekspedisiController.text = transaksiItem.ekspedisi;
      statusPembayaranController.text = transaksiItem.statusPembayaran;
      customerIdController.text = transaksiItem.customerId;
    }
    //rubah
    return Scaffold(
      appBar: AppBar(
        title: transaksiItem == null ? Text('Tambah') : Text('Ubah'),
        backgroundColor: Colors.blueGrey[200],
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            //cust id
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: customerIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Customer ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            //total harga
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: totalHargaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Total Harga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            //metode pembayaran
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: metodePembayaranController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Metode Pembayaran',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            //ekspedisi
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: ekspedisiController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Ekspedisi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            //status pembayaran
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: statusPembayaranController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Status Pembayaran',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            // button
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  // tombol simpan
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blueGrey[200],
                      child: Text(
                        'Save',
                        textScaleFactor: 1,
                      ),
                      onPressed: () {
                        if (transaksiItem == null) {
                          // tambah data
                          transaksiItem = TransaksiItem(
                            int.parse(customerIdController.text),
                            double.parse(totalHargaController.text),
                            metodePembayaranController.text,
                            ekspedisiController.text,
                            statusPembayaranController.text,
                          );
                        } else {
                          // ubah data
                          transaksiItem.customerId = customerIdController.text;
                          transaksiItem.totalHarga = totalHargaController.text;
                          transaksiItem.metodePembayaran =
                              metodePembayaranController.text;
                          transaksiItem.ekspedisi = ekspedisiController.text;
                          transaksiItem.statusPembayaran =
                              statusPembayaranController.text;
                        }
                        // kembali ke layar sebelumnya dengan membawa objek item
                        Navigator.pop(context, transaksiItem);
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  // tombol batal
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blueGrey[200],
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
