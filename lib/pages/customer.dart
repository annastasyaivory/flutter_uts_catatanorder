import 'dart:ui';

import 'package:flutter_uts_catatanorder/form/customerentryform.dart';
import 'package:flutter_uts_catatanorder/db/dbhelper.dart';
import 'package:flutter_uts_catatanorder/models/customerItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Customer extends StatefulWidget {
  @override
  CustomerState createState() => CustomerState();
}

class CustomerState extends State<Customer> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<CustomerItem> itemList;
  @override
  // untuk menampilkan data yang sudah diisikan
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<CustomerItem>();
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Customer'),
        backgroundColor: Colors.blueGrey[200],
      ),
      body: Column(
        children: [
          Expanded(
            child: createListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.blueGrey[200],
        child: Icon(Icons.add),
        tooltip: 'Add Customer',
        onPressed: () async {
          var item = await navigateToEntryForm(context, null);
          if (item != null) {
            //TODO 2 Panggil Fungsi untuk Insert ke DB
            int result = await dbHelper.insertCustomerItem(item);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }

  Future<CustomerItem> navigateToEntryForm(
      BuildContext context, CustomerItem customerItem) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return CustomerEntryForm(customerItem);
        },
      ),
    );
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          margin: EdgeInsets.all(8),
          child: ListTile(
            // widget yang akan menampilkan sebelum title
            leading: Column(
              children: [
                Text('CUST ID'),
                Text(
                  this.itemList[index].id.toString(),
                  style: TextStyle(fontSize: 35),
                ),
              ],
            ),
            title: Text(
              this.itemList[index].nama,
              style: textStyle,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    new Icon(
                      Icons.call,
                      color: Colors.black,
                    ),
                    Text(' ' + this.itemList[index].notelp),
                  ],
                ),
                Row(
                  children: [
                    new Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    Text(' ' + this.itemList[index].alamat),
                  ],
                ),
              ],
            ),
            // widget yang akan menampilkan setelah title
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    var item = await navigateToEntryForm(
                        context, this.itemList[index]);
                    //TODO 4 Panggil Fungsi untuk Edit data
                    if (item != null) editItem(item);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                    deleteItem(itemList[index]);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //delete Item
  void deleteItem(CustomerItem object) async {
    int result = await dbHelper.deleteCustomerItem(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //edit data
  void editItem(CustomerItem object) async {
    int result = await dbHelper.updateCustomerItem(object);
    if (result > 0) {
      updateListView();
    }
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<CustomerItem>> itemListFuture =
          dbHelper.getCustomerItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
