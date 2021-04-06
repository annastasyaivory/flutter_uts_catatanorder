class TransaksiItem {
  int _id;
  int _customerId;

  int _totalHarga;
  String _metodePembayaran;
  String _ekspedisi;
  String _statusPembayaran;

  int get id => this._id;

  get customerId => this._customerId;

  set customerId(value) => this._customerId = value;

  get totalHarga => this._totalHarga;

  set totalHarga(value) => this._totalHarga = value;

  get metodePembayaran => this._metodePembayaran;

  set metodePembayaran(value) => this._metodePembayaran = value;

  get ekspedisi => this._ekspedisi;

  set ekspedisi(value) => this._ekspedisi = value;

  get statusPembayaran => this._statusPembayaran;

  set statusPembayaran(value) => this._statusPembayaran = value;

  // konstruktor versi 1
  TransaksiItem(this._customerId, this._totalHarga, this._metodePembayaran,
      this._ekspedisi, this._statusPembayaran);

  // konstruktor versi 2: konversi dari Map ke Item
  TransaksiItem.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._customerId = map['customerId'];
    this._totalHarga = map['totalHarga'];
    this._metodePembayaran = map['metodePembayaran'];
    this._ekspedisi = map['ekspedisi'];
    this._statusPembayaran = map['statusPembayaran'];
  }

  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['customerId'] = this._customerId;
    map['totalHarga'] = totalHarga;
    map['metodePembayaran'] = metodePembayaran;
    map['ekspedisi'] = ekspedisi;
    map['statusPembayaran'] = statusPembayaran;
    return map;
  }
}
