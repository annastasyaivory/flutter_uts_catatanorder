import 'package:flutter_uts_catatanorder/models/customerItem.dart'; //import file model untuk tabel CustomerItem
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerEntryForm extends StatefulWidget {
  final CustomerItem customerItem;
  CustomerEntryForm(this.customerItem);
  @override
  CustomerEntryFormState createState() =>
      CustomerEntryFormState(this.customerItem);
}

class CustomerEntryFormState extends State<CustomerEntryForm> {
  CustomerItem customerItem;
  CustomerEntryFormState(this.customerItem);
  TextEditingController namaController =
      TextEditingController(); //controller untuk nama
  TextEditingController notelpController =
      TextEditingController(); //controller untuk notelp
  TextEditingController alamatController =
      TextEditingController(); //controller untuk alamat

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (customerItem != null) {
      namaController.text = customerItem.nama;
      notelpController.text = customerItem.notelp;
      alamatController.text = customerItem.alamat;
    }
    //rubah
    return Scaffold(
      appBar: AppBar(
        title: customerItem == null
            ? Text('Tambah')
            : Text('Ubah'), //title app bar disesuaikan kondisi
        backgroundColor: Colors.blueGrey[200],
        //icon button untuk back ke halaman sebelumnya
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
          //penggunaan listview agar berjajar
          children: <Widget>[
            //nama
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: namaController, //mengontrol teks yang sedang diedit
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            //notelp
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller:
                    notelpController, //mengontrol teks yang sedang diedit
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'No Telp',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            //alamat
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller:
                    alamatController, //mengontrol teks yang sedang diedit
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Alamat',
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
                //penggunaan row agar kedua button berada dalam 1 baris
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
                        if (customerItem == null) {
                          // tambah data
                          customerItem = CustomerItem(namaController.text,
                              notelpController.text, alamatController.text);
                        } else {
                          // ubah data
                          customerItem.nama = namaController.text;
                          customerItem.notelp = notelpController.text;
                          customerItem.alamat = alamatController.text;
                        }
                        // kembali ke layar sebelumnya dengan membawa objek item
                        Navigator.pop(context, customerItem);
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
