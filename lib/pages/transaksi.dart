import 'package:flutter_uts_catatanorder/form/transaksientryform.dart';
import 'package:flutter_uts_catatanorder/db/dbhelper.dart';
import 'package:flutter_uts_catatanorder/models/transaksiItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

class Transaksi extends StatefulWidget {
  @override
  TransaksiState createState() => TransaksiState();
}

class TransaksiState extends State<Transaksi> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<TransaksiItem> itemList;

  @override
  // untuk menampilkan data yang sudah diisikan
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<TransaksiItem>();
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Transaksi'),
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
        tooltip: 'Add Transaksi',
        onPressed: () async {
          var item = await navigateToEntryForm(context, null);
          if (item != null) {
            //TODO 2 Panggil Fungsi untuk Insert ke DB
            int result = await dbHelper.insertTransaksiItem(item);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }

  Future<TransaksiItem> navigateToEntryForm(
      BuildContext context, TransaksiItem transaksiItem) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TransaksiEntryForm(transaksiItem);
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
            leading: Text(
              this.itemList[index].customerId.toString(),
              style: TextStyle(fontSize: 35),
            ),
            title: Text(
              'Rp ' + this.itemList[index].totalHarga.toString(),
              style: textStyle,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(this.itemList[index].metodePembayaran),
                Text(this.itemList[index].ekspedisi),
                Text(this.itemList[index].statusPembayaran),
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
  void deleteItem(TransaksiItem object) async {
    int result = await dbHelper.deleteTransaksiItem(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //edit data
  void editItem(TransaksiItem object) async {
    int result = await dbHelper.updateTransaksiItem(object);
    if (result > 0) {
      updateListView();
    }
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<TransaksiItem>> itemListFuture =
          dbHelper.getTransaksiItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
