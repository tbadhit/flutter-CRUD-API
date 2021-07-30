import 'package:flutter/cupertino.dart';
import 'package:inventory_app/model/response_barang.dart';
import 'package:inventory_app/model/response_crud.dart';
import 'package:inventory_app/service/item_services.dart';

class ItemProvider extends ChangeNotifier {
  // AGAR BISA DI FETCH DATANYA :
  ItemProvider() {
    getListItem();
  }

  ItemServices _itemServices = ItemServices();

  // GET
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  List<Barang> _listItem = [];
  List<Barang> get listItem => _listItem;

  // CRUD
  ResponseCrud? _responseCrud;
  ResponseCrud? get responseCrud => _responseCrud;

  // SEARCH
  List<Barang>? _listItemSearch = [];
  List<Barang>? get listItemSearch => _listItemSearch;

  // GET (GET)
  Future<void> getListItem() async {
    _isFetching = true;
    notifyListeners();
    _listItem = await _itemServices.getListItem();
    _isFetching = false;
    notifyListeners();
  }

  // INSERT (CRUD)
  Future<void> insertItem(String nama, String jumlah, String gambar) async {
    final response = await _itemServices.insertItem(nama, jumlah, gambar);
    _responseCrud = response;

    Barang item = Barang();
    item.barangNama = nama;
    item.barangJumlah = jumlah;
    item.barangGambar = gambar;
    item.barangId = response!.lastId.toString();

    _listItem.add(item);
    notifyListeners();
  }

  // UPDATE (CRUD)
  Future<void> updateItem(
      String id, String nama, String jumlah, String gambar) async {
    final response = await _itemServices.updateItem(id, nama, jumlah, gambar);

    _responseCrud = response;

    var index = _listItem.indexWhere((item) => item.barangId == id);
    _listItem[index] = Barang(
        barangId: id,
        barangNama: nama,
        barangJumlah: jumlah,
        barangGambar: gambar);

    notifyListeners();
  }

  // DELETE (CRUD)
  Future<void> deleteItem(String id) async {
    final response = await _itemServices.deleteItem(id);

    _responseCrud = response;
    _listItem.removeWhere((item) => item.barangId == id);
    notifyListeners();
  }

  // SEARCH (SEARCH)
  void searchItem(String search) {
    List<Barang> listSearch = [];

    if (search.isEmpty) {
      listSearch.clear();
      _listItemSearch = listSearch;
    } else {
      _listItem.forEach((item) {
        if (item.barangNama!.toLowerCase().contains(search)) {
          listSearch.add(item);
        }
      });
      _listItemSearch = listSearch;
    }
    notifyListeners();
  }
}
