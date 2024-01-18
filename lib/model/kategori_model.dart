class Kategori {
  int? kategoriId;
  String? kategoriBaslik;

  Kategori(
   this. kategoriBaslik, //kategori eklemek için kullanılır,kategoriID degeri otomatik verilir.
  );

  Kategori.WithID(
     //kategori okumak için kullanılır.
   this. kategoriId,
  this. kategoriBaslik,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["kategoriID"] = kategoriId;
    map["kategoriBaslik"] = kategoriBaslik;
    return map;
  }

  Kategori.fromMap(Map<String, dynamic> map) {
    this.kategoriId = map["kategoriID"];
    this.kategoriBaslik = map["kategoriBaslik"];
  }

  @override
  String toString() =>
      'Kategori(kategoriID: $kategoriId, kategoriBaslik: $kategoriBaslik)';
}