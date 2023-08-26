  import 'package:flutter/material.dart';

import '../constant/font_color.dart';

DataCell dataCell(String text, {required Function onPressed}) {
    return DataCell(
      TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style: Sabitler.turuncuYaziTipi,
        ),
      ),
    );
  }
    DataCell textDataCell(String text) {
    return DataCell(
      Text(
        text,
        style: Sabitler.turuncuYaziTipi,
      ),
    );
  }