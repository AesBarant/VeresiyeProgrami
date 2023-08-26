import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
import 'package:veresiye_programi/page/toptanci_page.dart';
import 'package:veresiye_programi/widgets/search_delegate.dart';
import '../constant/font_color.dart';
import '../model/musteri.dart';
import '../model/toptanci.dart';
import '../widgets/floating_ac.dart';
import 'musteri_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MusteriClass> _musteriList;
  late List<ToptanciClass> _toptanciList;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _toptanciController = TextEditingController();
  @override
  void initState() {
    _musteriList = Hive.box<MusteriClass>("musteri").values.toList();
    _toptanciList = Hive.box<ToptanciClass>("toptanci").values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Sabitler.beyaz,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0, top: 8, bottom: 8),
              child: IconButton(
                onPressed: () {
                  // _showSearchPage();
                },
                icon: const Icon(
                  Icons.search,
                  size: 34,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, top: 8, bottom: 8),
              child: IconButton(
                onPressed: () {
                  setState(() {});
                  _musteriList =
                      Hive.box<MusteriClass>("musteri").values.toList();
                  debugPrint(Hive.box<MusteriClass>("musteri")
                      .values
                      .toList()
                      .toString());
                  //
                  _toptanciList =
                      Hive.box<ToptanciClass>("toptanci").values.toList();
                  debugPrint(Hive.box<ToptanciClass>("toptanci")
                      .values
                      .toList()
                      .toString());
                },
                icon: const Icon(
                  Icons.restart_alt,
                  size: 34,
                ),
              ),
            ),
          ],
          title: Text(
            "GÜMÜŞ VERESİYE",
            style: Sabitler.beyazYaziTipi,
          ),
          bottom: TabBar(indicatorColor: Sabitler.beyaz, tabs: [
            Text(
              "MÜŞTERİ",
              style: Sabitler.beyazYaziTipi,
            ),
            Text(
              "TOPTANCI",
              style: Sabitler.beyazYaziTipi,
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            MusteriPage(musteriList: _musteriList),
            ToptanciPage(toptanciList: _toptanciList),
          ],
        ),
        floatingActionButton: FloatAC(
          nameController: _nameController,
          addressController: _addressController,
          numberController: _numberController,
          toptanciController: _toptanciController,
          musteriEkle: () {
            _musteriEkle();
          },
          toptanciEkle: () {
            _toptanciEkle();
          },
        ),
      ),
    );
  }

  void _musteriEkle() async {
    final box = Hive.box<MusteriClass>("musteri");
    final newBox = MusteriClass(
      id: const Uuid().v1(),
      name: _nameController.text.toUpperCase(),
      address: _addressController.text,
      number: _numberController.text,
      totalPrice: 0,
      ayrinti: [],
    );
    await box.add(newBox);
    _musteriList.add(newBox);

    _nameController.clear();
    _addressController.clear();
    _numberController.clear();
    setState(
      () {
        _musteriList = box.values.toList();
        debugPrint(_musteriList.toString());
      },
    );
  }

  void _toptanciEkle() async {
    final box = Hive.box<ToptanciClass>("toptanci");
    final newBox = ToptanciClass(
      id: const Uuid().v1(),
      tName: _toptanciController.text.toUpperCase(),
      tTotalPrice: 0,
      tAyrinti: [],
    );
    _toptanciList.add(newBox);
    await box.add(newBox);
    _toptanciController.clear();
    setState(
      () {
        _toptanciList = box.values.toList();
        debugPrint(_toptanciList.toString());
      },
    );
  }

  void _showSearchPage() {
    showSearch(context: context, delegate: CustomSearchDelegate());
  }
}
