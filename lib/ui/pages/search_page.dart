import 'package:flutter/material.dart';
import 'package:inventory_app/model/response_barang.dart';
import 'package:inventory_app/provider/item_provider.dart';
import 'package:inventory_app/ui/pages/form_page.dart';
import 'package:inventory_app/ui/widget/item.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const String id = "SEARCH_PAGE";
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Consumer<ItemProvider>(
            builder: (context, itemProvider, _) => TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter Keywords",
                  filled: true,
                  fillColor: Colors.white),
              onChanged: (newValue) {
                // Action
                itemProvider.searchItem(newValue);
              },
            ),
          ),
        ),
        body: Consumer<ItemProvider>(
          builder: (context, itemProvider, _) {
            List<Barang>? listItem = itemProvider.listItemSearch;

            if (listItem != null) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: listItem.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      child: item(listItem[index]),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormPage(
                                    item: listItem[index],
                                    title: "Update data")));
                      },
                    );
                  });
            } else {
              return Center(
                child: Text('Search'),
              );
            }
          },
        ));
  }
}
