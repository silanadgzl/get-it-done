import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './item.dart';


class ItemData with ChangeNotifier{
  final List<Item> _items = [];

  static late SharedPreferences _sharedPref;
  final List<String> _itemAsString=[];

  void toggleStatus(int index){
    _items[index].ttoggleStatus();
    saveItemsToSharedPref(_items);
    notifyListeners();

  }

  void addItem(String title){
    _items.add(Item(title: title));
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  void deleteItem(int index){
    _items.removeAt(index);
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);


  ///Shared Pref metotları

  Future<void> createPrefObject()async{
    _sharedPref=await SharedPreferences.getInstance();
  }

  void saveItemsToSharedPref(List<Item> items){
    //List<Item> --> List<String>
    _itemAsString.clear();

    for(var item in items){
      _itemAsString.add(json.encode(item.toMap()));
    }

    //sharedpref kaydetsin
    _sharedPref.setStringList("toDoData", _itemAsString);
  }

  void loadItemsFromSharedPref(){
    List<String>? tempList=_sharedPref.getStringList("toDoData")??[];
    _items.clear();
    for(var item in tempList!){
      _items.add(Item.fromMap(json.decode(item)));
    }
  }
}
