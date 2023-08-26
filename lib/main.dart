import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:veresiye_programi/model/musteri.dart';
import 'package:veresiye_programi/page/home_page.dart';

import 'constant/font_color.dart';
import 'model/toptanci.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter("veresiye_database");
  Hive.registerAdapter(MusteriClassAdapter());
  Hive.registerAdapter(MusteriAyrintiClassAdapter());
  Hive.registerAdapter(ToptanciClassAdapter());
  Hive.registerAdapter(ToptanciAyrintiClassAdapter());
  await Hive.openBox<MusteriClass>("musteri");
  await Hive.openBox<ToptanciClass>("toptanci");
  //await Hive.openBox<MusteriClass>("musteriAyrinti");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData(
          useMaterial3: false,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange.shade300,
              foregroundColor: Sabitler.beyaz),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepOrange.shade300,
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Sabitler.turuncu),
              overlayColor: MaterialStatePropertyAll(
                Colors.deepPurple.shade50,
              ),
            ),
          ),
        ),
        home: const HomePage());
  }
}
