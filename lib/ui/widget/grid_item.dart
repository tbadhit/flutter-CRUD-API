import 'package:flutter/material.dart';
import 'package:inventory_app/provider/item_provider.dart';
import 'package:inventory_app/ui/pages/form_page.dart';
import 'package:inventory_app/ui/widget/item.dart';
import 'package:provider/provider.dart';

class GridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: itemProvider.isFetching
            ? CircularProgressIndicator()
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: itemProvider.listItem.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                    child: item(itemProvider.listItem[index]),
                    onTap: () {
                      // Action
                      // AFTER UI (UPDATE)
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FormPage(
                                  item: itemProvider.listItem[index],
                                  title: "Update data")));
                    },
                  );
                },
              ),
      ),
    );
  }
}
