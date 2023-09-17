import 'package:flutter/material.dart';


class ItemCard extends StatelessWidget {
  final String title;
  final bool? isDone;
  final Function(bool?) toggleStatus;
  final Function deleteItem;

  ItemCard({required this.title, required this.isDone,required this.toggleStatus,required this.deleteItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) => deleteItem(),
      key: UniqueKey(), //widget oluşturulurken ona özgü key değeri verir
      child: Card(
        color: isDone==true ? Colors.green.shade50:Colors.white,
        elevation: isDone==true ? 1 : 5,
        shadowColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: Text(title, style: TextStyle(
              color: Colors.black,
              decoration: isDone==true ? TextDecoration.lineThrough:null)),
          trailing: Checkbox(
              value: isDone,
              onChanged: toggleStatus,
              activeColor: Colors.green,
          ),
        ),
      ),
    );
  }
}