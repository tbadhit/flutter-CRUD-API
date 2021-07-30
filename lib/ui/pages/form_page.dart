import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_app/model/response_barang.dart';
import 'package:inventory_app/provider/item_provider.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  static const String id = "FORM_PAGE";
  final Barang? item;
  final String title;
  const FormPage({Key? key, required this.item, required this.title})
      : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _countController;
  late TextEditingController _urlController;

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Please enter field";
    } else {
      return null;
    }
  }

  // AFTER UI
  AutovalidateMode _validate = AutovalidateMode.disabled;
  // bool _isUpdate = false;
  ItemProvider? itemProvider;
  String? _idItem;

  void checkValidation() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (widget.item!.barangId != null) {
        await itemProvider!.updateItem(_idItem!, _nameController.text,
            _countController.text, _urlController.text);
      } else {
        await itemProvider!.insertItem(
            _nameController.text, _countController.text, _urlController.text);
      }

      // Before create update
      // await itemProvider!.insertItem(
      //     _nameController.text, _countController.text, _urlController.text);

      bool _success = itemProvider!.responseCrud!.sukses;

      if (_success) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      _validate = AutovalidateMode.always;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final itemProvider = Provider.of<ItemProvider>(context);

    if (this.itemProvider != itemProvider) {
      this.itemProvider = itemProvider;
    }
  }

  @override
  void initState() {
    super.initState();

    // (UPDATE)
    if (widget.item != null) {
      _idItem = widget.item!.barangId;
    }
    // -----------

    _nameController = TextEditingController(text: widget.item!.barangNama);
    _countController = TextEditingController(text: widget.item!.barangJumlah);
    _urlController = TextEditingController(text: widget.item!.barangGambar);
  }

  @override
  Widget build(BuildContext context) {
    // AFTER UI
    // (DELETE)
    ItemProvider itemProvider = Provider.of<ItemProvider>(context);
    //--------
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        actions: [
          // (DELETE)
          widget.item!.barangId != null
              ? IconButton(
                  onPressed: () async {
                    // Action
                    await itemProvider.deleteItem(_idItem!);
                    if (itemProvider.responseCrud!.sukses) {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "Delete Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Delete Failed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  icon: Icon(Icons.delete))
              : Text("")
          //-----------------
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            // AFTER UI
            autovalidateMode: _validate,
            //-----
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Item Name'),
                      validator: validator),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: TextFormField(
                      controller: _countController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Item Count'),
                      validator: validator),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: TextFormField(
                      controller: _urlController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Url Item'),
                      validator: validator),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Action
                      // AFTER UI
                      checkValidation();
                      //-------------
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
