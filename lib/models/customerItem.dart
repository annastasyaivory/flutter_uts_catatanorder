class CustomerItem {
  int _id;
  String _nama;
  String _notelp;
  String _alamat;

  int get id => this._id;

  get nama => this._nama;

  set nama(value) => this._nama = value;

  get notelp => this._notelp;

  set notelp(value) => this._notelp = value;

  get alamat => this._alamat;

  set alamat(value) => this._alamat = value;

  // konstruktor versi 1
  CustomerItem(this._nama, this._notelp, this._alamat);

  // konstruktor versi 2: konversi dari Map ke Item
  CustomerItem.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._notelp = map['notelp'];
    this._alamat = map['alamat'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['notelp'] = notelp;
    map['alamat'] = alamat;
    return map;
  }
}
