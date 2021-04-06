import 'dart:io';
import 'package:flutter_uts_catatanorder/models/customerItem.dart';
import 'package:flutter_uts_catatanorder/models/transaksiItem.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'catatanOrder.db';

    //create, read databases
    var daftarLaguDatabase = openDatabase(path,
        version: 2, onCreate: _createDb, onUpgrade: _onUpgrade);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return daftarLaguDatabase;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      // db.execute(""); // SQL Query
    }
  }

  // untuk membuat tabel pada database
  void _createDb(Database db, int version) async {
    Batch batch = db.batch();
    // tabel customerItem
    batch.execute('''CREATE TABLE customerItem (
id INTEGER PRIMARY KEY AUTOINCREMENT,
nama TEXT,
notelp TEXT,
alamat TEXT)''');
    // tabel transaksiItem
    batch.execute('''CREATE TABLE transaksiItem (
id INTEGER PRIMARY KEY AUTOINCREMENT,
totalHarga INTEGER,
metodePembayaran TEXT,
ekspedisi TEXT,
statusPembayaran TEXT,
customerId INTEGER, 
          FOREIGN KEY (customerId) REFERENCES customerItem(id) 
          )''');
    List<dynamic> res = await batch.commit();
  }

  //select data tabel CustomerItem
  Future<List<Map<String, dynamic>>> selectCustomerItem() async {
    Database db = await this.initDb();
    var mapList = await db.query('customerItem', orderBy: 'id');
    return mapList;
  }

  //select data tabel transaksiItem
  Future<List<Map<String, dynamic>>> selectTransaksiItem() async {
    Database db = await this.initDb();
    var mapList = await db.query('transaksiItem', orderBy: 'id');
    return mapList;
  }

  // insert data tabel customerItem
  Future<int> insertCustomerItem(CustomerItem object) async {
    Database db = await this.initDb();
    int count = await db.insert('customerItem', object.toMap());
    return count;
  }

  // insert data tabel TransaksiItem
  Future<int> insertTransaksiItem(TransaksiItem object) async {
    Database db = await this.initDb();
    int count = await db.insert('transaksiItem', object.toMap());
    return count;
  }

  //update data tabel customerItem
  Future<int> updateCustomerItem(CustomerItem object) async {
    Database db = await this.initDb();
    int count = await db.update('customerItem', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //update data tabel TransaksiItem
  Future<int> updateTransaksiItem(TransaksiItem object) async {
    Database db = await this.initDb();
    int count = await db.update('transaksiItem', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete data tabel customerItem
  Future<int> deleteCustomerItem(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('customerItem', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //delete data tabel TransaksiItem
  Future<int> deleteTransaksiItem(int id) async {
    Database db = await this.initDb();
    int count =
        await db.delete('transaksiItem', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<CustomerItem>> getCustomerItemList() async {
    var itemMapList = await selectCustomerItem();
    int count = itemMapList.length;
    List<CustomerItem> itemList = List<CustomerItem>();
    for (int i = 0; i < count; i++) {
      itemList.add(CustomerItem.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  Future<List<TransaksiItem>> getTransaksiItemList() async {
    var itemMapList = await selectTransaksiItem();
    int count = itemMapList.length;
    List<TransaksiItem> itemList = List<TransaksiItem>();
    for (int i = 0; i < count; i++) {
      itemList.add(TransaksiItem.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
