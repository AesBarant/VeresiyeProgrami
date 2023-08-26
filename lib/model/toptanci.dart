import 'package:hive/hive.dart';
part 'toptanci.g.dart';
@HiveType(typeId: 3)
class ToptanciClass {
  ToptanciClass({
    required this.id,
    required this.tName,
    required this.tTotalPrice,
    required this.tAyrinti,
  });
  @HiveField(11)
  String id;
  @HiveField(12)
  String tName;
  @HiveField(13)
  double tTotalPrice;
  @HiveField(14)
  List<ToptanciAyrintiClass> tAyrinti;
}

@HiveType(typeId: 4)
class ToptanciAyrintiClass {
  ToptanciAyrintiClass({
    required this.id,
    required this.tAciklama,
    required this.tBorc,
    required this.tOdenen,
    required this.tTarih,
  });
  @HiveField(15)
  String id;
  @HiveField(16)
  String tAciklama;
  @HiveField(17)
  double tBorc;
  @HiveField(18)
  double tOdenen;
  @HiveField(19)
  DateTime tTarih;
}
