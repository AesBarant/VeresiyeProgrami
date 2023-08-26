import 'package:flutter/material.dart';
import '../constant/font_color.dart';

class FloatAC extends StatefulWidget {
  final Function musteriEkle;
  final Function toptanciEkle;
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController numberController;
  final TextEditingController toptanciController;
  const FloatAC({
    required this.nameController,
    required this.addressController,
    required this.numberController,
    required this.toptanciController,
    required this.toptanciEkle,
    required this.musteriEkle,
    super.key,
  });

  @override
  State<FloatAC> createState() => _FloatACState();
}

class _FloatACState extends State<FloatAC> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Müşteri Ekle",
                                style: Sabitler.turuncuYaziTipi,
                              ),
                              content: SizedBox(
                                height: 200,
                                child: Column(
                                  children: [
                                    textField(
                                        widget.nameController, "İsim Gir"),
                                    textField(
                                        widget.addressController, "Adres Gir"),
                                    textField(
                                        widget.numberController, "Numara Gir"),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    widget.musteriEkle();
                                  },
                                  child: const Text("Kaydet"),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Sabitler.turuncu,
                          child: Center(
                            child: Text(
                              "Müşteri Ekle",
                              style: Sabitler.beyazYaziTipi,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Toptancı Ekle",
                              ),
                              content: SizedBox(
                                height: 200,
                                child: Column(
                                  children: [
                                    textField(
                                        widget.toptanciController, "İsim Gir")
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    widget.toptanciEkle();
                                  },
                                  child: const Text("Kaydet"),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: 200,
                          height: 200,
                          color: Sabitler.turuncu,
                          child: Center(
                            child: Text(
                              "Toptancı Ekle",
                              style: Sabitler.beyazYaziTipi,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  TextField textField(TextEditingController controller, String text) {
    return TextField(
      controller: controller,
      cursorColor: Sabitler.turuncu,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: Sabitler.turuncuYaziTipi,
      ),
    );
  }
}
