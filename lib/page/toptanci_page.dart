import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:veresiye_programi/controller/toptanci_ayrinti.dart';
import '../constant/font_color.dart';

import '../model/toptanci.dart';
import '../widgets/datacell.dart';

// ignore: must_be_immutable
class ToptanciPage extends StatefulWidget {
  List<ToptanciClass> toptanciList;
  ToptanciPage({
    required this.toptanciList,
    super.key,
  });

  @override
  State<ToptanciPage> createState() => _ToptanciPageState();
}

class _ToptanciPageState extends State<ToptanciPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          //DataColumn(label: Text("İD", style: Sabitler.turuncuYaziTipi)),
          DataColumn(label: Text("İSİM", style: Sabitler.turuncuYaziTipi)),
          DataColumn(label: Text("TUTAR", style: Sabitler.turuncuYaziTipi)),
          DataColumn(label: Text("AYRINTI", style: Sabitler.turuncuYaziTipi)),
          DataColumn(label: Text("SİL", style: Sabitler.turuncuYaziTipi)),
        ],
        rows: List<DataRow>.generate(
          widget.toptanciList.length,
          (index) => musteriDataRow(index),
        ),
      ),
    );
  }

  DataRow musteriDataRow(int index) {
    final oAnkiMusteri = widget.toptanciList[index];
    return DataRow(cells: [
      //textDataCell(oAnkiMusteri.id.toString()),
      dataCell(oAnkiMusteri.tName, onPressed: () {
        _duzenle(
            oAnkiMusteri.tName,
            (yeniIsim) => setState(() {
                  oAnkiMusteri.tName = yeniIsim;
                }),
            oAnkiMusteri);
      }),
      textDataCell(oAnkiMusteri.tTotalPrice.toString()),
      dataCell("Ayrıntıları Göster", onPressed: () {
        setState(() {
          toptanciAyrintiGoster(
            context,
            widget.toptanciList,
            oAnkiMusteri.id,
          );
          Hive.box<ToptanciClass>("toptanci").compact();
        });
      }),
      dataCell("Sil", onPressed: () => _sil(oAnkiMusteri.id))
    ]);
  }

  void _duzenle(
    String mevcutDeger,
    void Function(dynamic) func,
    ToptanciClass oAnkiMusteri,
  ) {
    var box = Hive.box<ToptanciClass>("toptanci");
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
                await Hive.box<ToptanciClass>("toptanci").compact();
                widget.toptanciList = box.values.toList();
              },
              child: const Text("Kaydet"),
            )
          ],
        );
      },
    );
  }

  void _sil(String oAnkimusteri) async {
    final box = Hive.box<ToptanciClass>("toptanci");
    setState(() {});
    final arananKey = box.keys.firstWhere(
        (key) => box.get(key)?.id == oAnkimusteri,
        orElse: () => null);

    widget.toptanciList.removeWhere((key) => key.id == oAnkimusteri);
    arananKey != null
        ? await box.delete(arananKey)
        : await null; // Veritabanından silme işlemi

    widget.toptanciList = box.values.toList();
    await Hive.box<ToptanciClass>("toptanci").compact();
  }
}
