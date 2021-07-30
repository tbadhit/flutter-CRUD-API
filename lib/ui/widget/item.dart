import 'package:flutter/material.dart';
import 'package:inventory_app/model/response_barang.dart';

Widget item(Barang item) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          child: Image.network(
            item.barangGambar!,
            height: 100,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.barangNama!,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                Text("${item.barangJumlah} buah")
              ],
            ),
          ),
        )
      ],
    ),
  );
}
