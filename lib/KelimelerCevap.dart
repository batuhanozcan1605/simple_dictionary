import 'package:dictionary/Kelimeler.dart';

class KelimelerCevap {
  int success;
  List<Kelimeler> kelimeListesi;

  KelimelerCevap(this.success, this.kelimeListesi);

  factory KelimelerCevap.fromJson(Map<String,dynamic> json) {
    var jsonArray = json["kelimeler"] as List;
    List<Kelimeler> kelimelerListesi = jsonArray.map((jsonArrayNesnesi) => Kelimeler.fromJson(jsonArrayNesnesi)).toList();
    return KelimelerCevap(json["success"] as int, kelimelerListesi);
  }
}