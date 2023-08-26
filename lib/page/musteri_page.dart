import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../constant/font_color.dart';
import '../controller/musteri_ayrinti.dart';
import '../model/musteri.dart';
import '../widgets/datacell.dart';

// ignore: must_be_immutable
class MusteriPage extends StatefulWidget {
  List<MusteriClass> musteriList;

  MusteriPage({
    required this.musteriList,
    super.key,
  });

  @override
  State<MusteriPage> createState() => _MusteriPageState();
}

class _MusteriPageState extends State<MusteriPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          //DataColumn(label: Text("İD", style: Sabitler.turuncuYaziTipi)),
          DataColumn(label: Text("İSİM", style: Sabitler.turuncuYaziTipi)),
          DataColumn(label: Text("ADRES", style: Sabitler.turuncuYaziTipi)),
          DataColumn(label: Text("TEL ", style: Sabitler.turuncuYaziTipi)),
          DataColumn(label: Text("TUTAR", style: Sabitler.turuncuYaziTipi)),
          DataColumn(label: Text("AYRINTI", style: Sabitler.turuncuYaziTipi)),
          DataColumn(label: Text("SİL", style: Sabitler.turuncuYaziTipi)),
        ],
        rows: List<DataRow>.generate(
          widget.musteriList.length,
          (index) => musteriDataRow(index),
        ),
      ),
    );
  }

  DataRow musteriDataRow(int index) {
    final oAnkiMusteri = widget.musteriList[index];
    return DataRow(cells: [
      //textDataCell(oAnkiMusteri.id.toString()),
      dataCell(oAnkiMusteri.name,
          onPressed: () => _duzenle(
              oAnkiMusteri.name,
              (yeniIsim) => setState(() {
                    oAnkiMusteri.name = yeniIsim;
                  }),
              oAnkiMusteri)),
      dataCell(oAnkiMusteri.address, onPressed: () {
        _duzenle(
            oAnkiMusteri.address,
            (yeniDeger) => setState(() {
                  oAnkiMusteri.address = yeniDeger;
                }),
            oAnkiMusteri);
      }),
      dataCell(oAnkiMusteri.number,
          onPressed: () => _duzenle(
              oAnkiMusteri.number,
              (yeniDeger) => setState(() {
                    oAnkiMusteri.number = yeniDeger;
                  }),
              oAnkiMusteri)),
      textDataCell(oAnkiMusteri.totalPrice.toString()),
      dataCell("Ayrıntıları Göster", onPressed: () async{
        setState(()  {
          ayrintiGoster(
            context,
            widget.musteriList,
            oAnkiMusteri.id,
          );
          Hive.box<MusteriClass>("musteri").compact();
        });
      }),
      dataCell("Sil", onPressed: () {
        setState(() {});
        _sil(oAnkiMusteri.id);
      })
    ]);
  }

  void _duzenle(
    String mevcutDeger,
    void Function(dynamic) func,
    MusteriClass oAnkiMusteri,
  ) {
    var box = Hive.box<MusteriClass>("musteri");
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Düzenle",
            style: Sabitler.turuncuYaziTipi,
          ),
          content: TextField(
            controller: _controller,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                setState(() {});
                String yeniDeger = _controller.text;
                func(yeniDeger);
                final arananKey = box.keys.firstWhere(
                  (key) => box.get(key) == oAnkiMusteri,
                  orElse: () => null,
                );
                await box.put(arananKey, oAnkiMusteri);
                await Hive.box<MusteriClass>("musteri").compact();
                widget.musteriList = box.values.toList();
              },
              child: const Text("Kaydet"),
            )
          ],
        );
      },
    );
  }

  void _sil(String oAnkimusteri) async {
    final box = Hive.box<MusteriClass>("musteri");
    setState(() {});
    final arananKey = box.keys.firstWhere(
        (key) => box.get(key)?.id == oAnkimusteri,
        orElse: () => null);

    if (arananKey != null) {
      await box.delete(arananKey); // Veritabanından silme işlemi
    }
    widget.musteriList.removeWhere((key) => key.id == oAnkimusteri);
    widget.musteriList = box.values.toList();
    await Hive.box<MusteriClass>("musteri").compact();
  }
}
