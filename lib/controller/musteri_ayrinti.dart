import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:veresiye_programi/model/musteri.dart';
import 'package:veresiye_programi/widgets/datacell.dart';
import '../constant/font_color.dart';
import '../widgets/textwidgets.dart';

final TextEditingController _aciklamaController = TextEditingController();
final TextEditingController _borcController = TextEditingController();
final TextEditingController _odenenController = TextEditingController();
ayrintiGoster(
    BuildContext context, List<MusteriClass> musteriList, String musteriId) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      final List<MusteriAyrintiClass> ayrintiList =
          musteriList.firstWhere((musteri) => musteri.id == musteriId).ayrinti;
      return SizedBox(
        height: 1200,
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: [
                          DataColumn(
                              label: Text("Açıklama",
                                  style: Sabitler.turuncuYaziTipi)),
                          DataColumn(
                              label: Text("Borç",
                                  style: Sabitler.turuncuYaziTipi)),
                          DataColumn(
                              label: Text("Ödenen",
                                  style: Sabitler.turuncuYaziTipi)),
                          DataColumn(
                              label: Text("Tarih",
                                  style: Sabitler.turuncuYaziTipi)),
                          DataColumn(
                              label:
                                  Text("Sil", style: Sabitler.turuncuYaziTipi)),
                        ],
                        rows: List<DataRow>.generate(
                          ayrintiList.length,
                          (index) => ayrintiDataRow(
                            context,
                            index,
                            musteriList,
                            musteriId,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          textField("Açıklama Yaz", _aciklamaController),
                          const SizedBox(height: 30),
                          textField("Borc Yaz", _borcController),
                          const SizedBox(height: 30),
                          textField("Odenen Yaz", _odenenController),
                          const SizedBox(height: 30),
                          TextButton(
                            onPressed: () {
                              ayritiEkle(musteriId, musteriList);
                              Navigator.pop(context);
                            },
                            child:
                                Text("Ekle", style: Sabitler.turuncuYaziTipi),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

DataRow ayrintiDataRow(
  BuildContext context,
  int index,
  List<MusteriClass> musteriList,
  String musteriId,
) {
  MusteriClass musteri =
      musteriList.firstWhere((musteri) => musteri.id == musteriId);
  // MusteriClass? musteri = Hive.box<MusteriClass>("musteri").get(musteriId);
  MusteriAyrintiClass oAnkiAyrinti = musteri.ayrinti[index];
  return DataRow(
    cells: [
      dataCell(
        oAnkiAyrinti.aciklama,
        onPressed: () {
          ayrintiDuzenle(
            musteriId,
            context,
            (String aciklama, double borc, double odenen) {
              oAnkiAyrinti.aciklama = aciklama;
              oAnkiAyrinti.borc = borc;
              oAnkiAyrinti.odenen = odenen;
            },
            oAnkiAyrinti,
            musteriList,
          );
        },
      ),
      dataCell(
        oAnkiAyrinti.borc.toString(),
        onPressed: () {
          ayrintiDuzenle(
            musteriId,
            context,
            (String aciklama, double borc, double odenen) {
              oAnkiAyrinti.aciklama = aciklama;
              oAnkiAyrinti.borc = borc;
              oAnkiAyrinti.odenen = odenen;
            },
            oAnkiAyrinti,
            musteriList,
          );
        },
      ),
      dataCell(
        oAnkiAyrinti.odenen.toString(),
        onPressed: () {
          ayrintiDuzenle(
            musteriId,
            context,
            (String aciklama, double borc, double odenen) {
              oAnkiAyrinti.aciklama = aciklama;
              oAnkiAyrinti.borc = borc;
              oAnkiAyrinti.odenen = odenen;
            },
            oAnkiAyrinti,
            musteriList,
          );
        },
      ),
      textDataCell(
        oAnkiAyrinti.tarih.toString(),
      ),
      dataCell("Sil", onPressed: () {
        ayrintiSil(context, musteriId, index, musteriList);
      }),
    ],
  );
}

void ayritiEkle(String musteriId, List<MusteriClass> musteriList) async {
  final box = Hive.box<MusteriClass>("musteri");

  // Varolan müşteri nesnesini al
  MusteriClass musteri =
      musteriList.firstWhere((musteri) => musteri.id == musteriId);

  // Yeni ayrıntı oluştur ve müşteri nesnesine ekle
  MusteriAyrintiClass newAyrinti = MusteriAyrintiClass(
    id: musteriId,
    aciklama: _aciklamaController.text,
    borc: double.tryParse(_borcController.text) ?? 0,
    odenen: double.tryParse(_odenenController.text) ?? 0,
    tarih: DateTime.now(),
  );
  musteri.ayrinti.add(newAyrinti);

  // Müşteri nesnesini güncelle
  _updateTotalPrice(musteriId, musteri);

  // Güncellenmiş müşteri nesnesini veritabanına kaydet
  await box.put(musteriId, musteri);
  await box.compact();
  musteriList = box.values.toList();

  _aciklamaController.clear();
  _borcController.clear();
  _odenenController.clear();
}

void ayrintiSil(BuildContext context, String musteriId, int index,
    List<MusteriClass> musteriList) async {
  final box = Hive.box<MusteriClass>("musteri");
  MusteriClass musteri =
      musteriList.firstWhere((musteri) => musteri.id == musteriId);
  musteri.ayrinti.removeAt(index);
  await box.delete(musteriId);
  musteriList = box.values.toList();
  Hive.box<MusteriClass>("musteri").compact();
  _updateTotalPrice(musteriId, musteri);
  Navigator.pop(context);
}

void ayrintiDuzenle(
  String musteriId,
  BuildContext context,
  Function(String, double, double) func,
  MusteriAyrintiClass ayrinti,
  List<MusteriClass> musteriList,
) {
  _aciklamaController.text = ayrinti.aciklama;
  _borcController.text = ayrinti.borc.toString();
  _odenenController.text = ayrinti.odenen.toString();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Ayrıntıları Düzenle",
          style: Sabitler.turuncuYaziTipi,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textField("Açıklama", _aciklamaController),
            textField("Borc", _borcController),
            textField("Ödenen", _odenenController),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              func(
                _aciklamaController.text,
                double.tryParse(_borcController.text) ?? 0,
                double.tryParse(_odenenController.text) ?? 0,
              );

              _updateTotalPrice(
                musteriId,
                musteriList.firstWhere((musteri) => musteri.id == ayrinti.id),
              );
              Hive.box<MusteriClass>("musteri").compact();
              _aciklamaController.clear();
              _borcController.clear();
              _odenenController.clear();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Kaydet"),
          ),
        ],
      );
    },
  );
}

void _updateTotalPrice(String musteriId, MusteriClass musteri) {
  final box = Hive.box<MusteriClass>("musteri");
  double totalBorc = 0;
  double totalOdenen = 0;

  musteri.ayrinti.forEach((ayrinti) {
    totalBorc += ayrinti.borc;
    totalOdenen += ayrinti.odenen;
  });

  double kalanBorc = totalBorc - totalOdenen;

  musteri.totalPrice = kalanBorc;
  box.put(musteriId, musteri);
}
