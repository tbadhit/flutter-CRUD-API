import 'dart:convert';

import 'package:inventory_app/model/response_barang.dart';

import 'package:http/http.dart' as http;
import 'package:inventory_app/model/response_crud.dart';

class ItemServices {
  final _host = '172.16.8.163';

  Future<List<Barang>> getListItem() async {
    final uri = Uri.http(_host, 'server_inventory/index.php/api/getBarang');
    List<Barang> listItem = [];
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ResponseBarang responseBarang = ResponseBarang.fromJson(json);

      responseBarang.barang.forEach((item) {
        listItem.add(item);
      });

      return listItem;
    } else {
      return [];
    }
  }

  Future<ResponseCrud?> insertItem(
      String nama, String jumlah, String gambar) async {
    final uri = Uri.http(_host, 'server_inventory/index.php/api/insertbarang');

    final response = await http
        .post(uri, body: {'nama': nama, 'jumlah': jumlah, 'gambar': gambar});

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      ResponseCrud responseCrud = ResponseCrud.fromJson(json);
      return responseCrud;
    } else {
      return null;
    }
  }

  Future<ResponseCrud?> updateItem(
      String id, String nama, String jumlah, String gambar) async {
    final uri = Uri.http(_host, 'server_inventory/index.php/api/updatebarang');

    final response = await http.post(uri,
        body: {"id": id, 'nama': nama, 'jumlah': jumlah, 'gambar': gambar});

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      ResponseCrud responseCrud = ResponseCrud.fromJson(json);
      return responseCrud;
    } else {
      return null;
    }
  }

  Future<ResponseCrud?> deleteItem(String id) async {
    final uri = Uri.http(_host, 'server_inventory/index.php/api/deletebarang');

    final response = await http.post(uri, body: {'id': id});

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      ResponseCrud responseCrud = ResponseCrud.fromJson(json);

      return responseCrud;
    } else {
      return null;
    }
  }
}
