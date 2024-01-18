// ignore_for_file: public_member_api_docs, sort_constructors_first
class Not {
  int? notId;
  int? kategoriId;
  String? kategoriBaslik;
  String? notBaslik;
  String? notIcerik;
  String? notTarih;
  int? notOncelik;
  Not(
    this.kategoriId,
    this.notBaslik,
    this.notIcerik,
    this.notTarih,
    this.notOncelik,
  );
  Not.WithID(
    this.notId,
    this.kategoriId,
    this.notBaslik,
    this.notIcerik,
    this.notTarih,
    this.notOncelik,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["notID"] = notId;
    map["kategoriID"] = kategoriId;
    map["notBaslik"] = notBaslik;
    map["notIcerik"] = notIcerik;
    map["notTarih"] = notTarih;
    map["notOncelik"] = notOncelik;
    return map;
  }

  Not.fromMap(Map<String, dynamic> map) {
    notId = map["notID"];
    kategoriId = map["kategoriID"];
    kategoriBaslik = map["kategoriBaslik"];
    notBaslik = map["notBaslik"];
    notIcerik = map["notIcerik"];
    notTarih = map["notTarih"];
    notOncelik = map["notOncelik"];
  }

  @override
  String toString() {
    return 'Not(notID: $notId, kategoriID: $kategoriId, notBaslik: $notBaslik, notIcerik: $notIcerik, notTarih: $notTarih, notOncelik: $notOncelik)';
  }
}