import 'package:flutter/material.dart';
import 'package:get_it_done/models/items_data.dart';
import 'package:get_it_done/settings_page.dart';
import 'package:get_it_done/widgets/item_cards.dart';
import 'package:provider/provider.dart';

import 'item_add.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              icon: const Icon(Icons.settings)),
        )
      ], title: const Text("Get It Done"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                    "${Provider.of<ItemData>(context).items.length} Items",
                    style: Theme.of(context).textTheme.headline3),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(//Burayı Consumer ile sarmalayabilirsiniz.Bütün scaffoldun yenilenmesi yerine sadece consumer olan kısım yenilenir
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: Provider.of<ItemData>(context).items.length,
                      itemBuilder: (context, index) => ItemCard(
                        title: Provider.of<ItemData>(context).items[index].title,
                        isDone: Provider.of<ItemData>(context).items[index].isDone,
                        toggleStatus: (bool) {Provider.of<ItemData>(context, listen: false).toggleStatus(index);
                        },
                        deleteItem: () {
                          Provider.of<ItemData>(context, listen: false).deleteItem(index);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              context: context,
              builder: (context) => SingleChildScrollView(child: ItemAdd()),
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
