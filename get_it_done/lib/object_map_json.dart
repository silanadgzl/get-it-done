import 'dart:convert';

main(){

  Item itemObject = Item(title: "uyu",isDone: true); //item sınıfını objeye çevirme
  print("itemObject $itemObject");
  print("itemObject Type: ${itemObject.runtimeType}");


  Map itemAsMap = itemObject.toMap(); //item objesini map'e çevirme
  print("itemAsMap: $itemAsMap");
  print("itemAsMap Type: ${itemAsMap.runtimeType}");

  String itemAsJson = json.encode(itemAsMap); //map'i json'a çevirme
  print("itemAsJson: $itemAsJson");
  print("itemAsJson Type: ${itemAsJson.runtimeType}");

  itemAsMap = json.decode(itemAsJson); //json=>map çevirme
  //itemObject = Item(title: itemAsMap["title"],isDone: itemAsMap["isDone"]);
  itemObject = Item.fromMap(itemAsMap);
  print("İtemObject: $itemObject");
}

class Item{
  String? title;
  bool? isDone;

  Item({this.title,this.isDone});
  Item.fromMap(Map<dynamic,dynamic> map):title=map["title"],isDone=map["isDone"];


  Map<dynamic,dynamic> toMap()=>{"title":title,"isDone":isDone};

}