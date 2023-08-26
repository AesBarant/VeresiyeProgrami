import 'package:hive/hive.dart';

part 'musteri.g.dart';

@HiveType(typeId: 1)
class MusteriClass {
  MusteriClass({
    required this.id,
    required this.name,
    required this.address,
    required this.number,
    required this.totalPrice,
    required this.ayrinti,
  });
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String address;
  @HiveField(3)
  String number;
  @HiveField(4)
  double totalPrice;
  @HiveField(5)
  List<MusteriAyrintiClass> ayrinti;
  @override
  String toString() {
    return "$name $ayrinti";
  }
}

@HiveType(typeId: 2)
class MusteriAyrintiClass {
  MusteriAyrintiClass({
    required this.id,
    required this.aciklama,
    required this.borc,
    required this.odenen,
    required this.tarih,
  });
  @HiveField(6)
  String id;
  @HiveField(7)
  String aciklama;
  @HiveField(8)
  double borc;
  @HiveField(9)
  double odenen;
  @HiveField(10)
  DateTime tarih;
  @override
  String toString() {
    return "$aciklama $borc $odenen";
  }
}
