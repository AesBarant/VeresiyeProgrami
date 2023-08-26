import 'package:flutter/material.dart';

import '../constant/font_color.dart';

TextField textField(String text, TextEditingController controller) {
    return TextField(
      cursorColor: Sabitler.turuncu,
      controller: controller,
      decoration: InputDecoration(
        label: Text(
          text,
          style: Sabitler.turuncuYaziTipi,
        ),
      ),
    );
  }