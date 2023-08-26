import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:veresiye_programi/model/toptanci.dart';
import 'package:veresiye_programi/widgets/datacell.dart';
import '../constant/font_color.dart';
import '../widgets/textwidgets.dart';

final TextEditingController _aciklamaController = TextEditingController();
final TextEditingController _borcController = TextEditingController();
final TextEditingController _odenenController = TextEditingController();
toptanciAyrintiGoster(
    BuildContext context, List<ToptanciClass> toptanciList, String toptanciId) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      final List<ToptanciAyrintiClass> ayrintiList = toptanciList
          .firstWhere((toptanci) => toptanci.id == toptanciId)
          .tAyrinti;
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
                            toptanciList,
                            toptanciId,
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
                              ayritiEkle(toptanciId, toptanciList);
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
  List<ToptanciClass> toptanciList,
  String toptanciId,
) {
  ToptanciClass musteri =
      toptanciList.firstWhere((toptanci) => toptanci.id == toptanciId);
  // ToptanciClass? musteri = Hive.box<ToptanciClass>("musteri").get(toptanciId);
  ToptanciAyrintiClass oAnkiAyrinti = musteri.tAyrinti[index];
  return DataRow(
    cells: [
      dataCell(
        oAnkiAyrinti.tAciklama,
        onPressed: () {
          ayrintiDuzenle(
            toptanciId,
            context,
            (String aciklama, double borc, double odenen) {
              oAnkiAyrinti.tAciklama = aciklama;
              oAnkiAyrinti.tBorc = borc;
              oAnkiAyrinti.tOdenen = odenen;
            },
            oAnkiAyrinti,
            toptanciList,
          );
        },
      ),
      dataCell(
        oAnkiAyrinti.tBorc.toString(),
        onPressed: () {
          ayrintiDuzenle(
            toptanciId,
            context,
            (String aciklama, double borc, double odenen) {
              oAnkiAyrinti.tAciklama = aciklama;
              oAnkiAyrinti.tBorc = borc;
              oAnkiAyrinti.tOdenen = odenen;
            },
            oAnkiAyrinti,
            toptanciList,
          );
        },
      ),
      dataCell(
        oAnkiAyrinti.tOdenen.toString(),
        onPressed: () {
          ayrintiDuzenle(
            toptanciId,
            context,
            (String aciklama, double borc, double odenen) {
              oAnkiAyrinti.tAciklama = aciklama;
              oAnkiAyrinti.tBorc = borc;
              oAnkiAyrinti.tOdenen = odenen;
            },
            oAnkiAyrinti,
            toptanciList,
          );
        },
      ),
      textDataCell(
        oAnkiAyrinti.tTarih.toString(),
      ),
      dataCell("Sil", onPressed: () {
        ayrintiSil(context, toptanciId, index, toptanciList);
      }),
    ],
  );
}

void ayritiEkle(String toptanciId, List<ToptanciClass> toptanciList) async {
  final box = Hive.box<ToptanciClass>("toptanci");

  // Varolan müşteri nesnesini al
  ToptanciClass toptanci =
      toptanciList.firstWhere((toptanci) => toptanci.id == toptanciId);

  // Yeni ayrıntı oluştur ve müşteri nesnesine ekle
  ToptanciAyrintiClass newAyrinti = ToptanciAyrintiClass(
    id: toptanciId,
    tAciklama: _aciklamaController.text,
    tBorc: double.tryParse(_borcController.text) ?? 0,
    tOdenen: double.tryParse(_odenenController.text) ?? 0,
    tTarih: DateTime.now(),
  );
  toptanci.tAyrinti.add(newAyrinti);

  // Müşteri nesnesini güncelle
  _updateTotalPrice(toptanciId, toptanci);

  // Güncellenmiş müşteri nesnesini veritabanına kaydet
  await box.put(toptanciId, toptanci);
  await box.compact();
  toptanciList = box.values.toList();

  _aciklamaController.clear();
  _borcController.clear();
  _odenenController.clear();
}

void ayrintiSil(BuildContext context, String toptanciId, int index,
    List<ToptanciClass> toptanciList) async {
  final box = Hive.box<ToptanciClass>("toptanci");
  ToptanciClass toptanci =
      toptanciList.firstWhere((toptanci) => toptanci.id == toptanciId);
  toptanci.tAyrinti.removeAt(index);
  await box.delete(toptanciId);
  toptanciList = box.values.toList();
  Hive.box<ToptanciClass>("toptanci").compact();
  _updateTotalPrice(toptanciId, toptanci);
  Navigator.pop(context);
}

void ayrintiDuzenle(
  String toptanciId,
  BuildContext context,
  Function(String, double, double) func,
  ToptanciAyrintiClass ayrinti,
  List<ToptanciClass> musteriList,
) {
  _aciklamaController.text = ayrinti.tAciklama;
  _borcController.text = ayrinti.tBorc.toString();
  _odenenController.text = ayrinti.tOdenen.toString();

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
                toptanciId,
                musteriList.firstWhere((musteri) => musteri.id == ayrinti.id),
              );
              Hive.box<ToptanciClass>("toptanci").compact();
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

void _updateTotalPrice(String toptanciId, ToptanciClass toptanci) {
  final box = Hive.box<ToptanciClass>("toptanci");
  double totalBorc = 0;
  double totalOdenen = 0;

  toptanci.tAyrinti.forEach((ayrinti) {
    totalBorc += ayrinti.tBorc;
    totalOdenen += ayrinti.tOdenen;
  });

  double kalanBorc = totalBorc - totalOdenen;

  toptanci.tTotalPrice = kalanBorc;
  box.put(toptanciId, toptanci);
}
