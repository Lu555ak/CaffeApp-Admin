import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  static Menu? _instance;

  Menu._();

  factory Menu() => _instance ??= Menu._();

  final List<MenuItem> _menu = List.empty(growable: true);

  int get getMenuLength => _menu.length;
  MenuItem getMenuItemAt(int index) => _menu[index];
  void removeMenuItemAt(int index) => _menu.removeAt(index);
  void addMenuItem(MenuItem menuItem) => _menu.add(menuItem);

  Future saveToDatabase() async {
    /*final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection = instance.collection("menu");
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    for (var menuItem in _menu) {
      await FirebaseFirestore.instance.collection("menu").add(menuItem.toMap());
    }*/
  }

  Future loadFromDatabase() async {
    await FirebaseFirestore.instance.collection("menu").get().then((snapshot) {
      for (var menuItem in snapshot.docs) {
        addMenuItem(MenuItem(menuItem["name"], menuItem["price"],
            menuItem["discount"], menuItem["featured"]));
      }
    });
  }
}

class MenuItem {
  String _name;
  double _price;
  late double _priceDiscount;
  int _discount;
  bool _featured;
  final List<String> _categories = [];

  MenuItem(this._name, this._price, this._discount, this._featured) {
    _priceDiscount = _price * (1 - _discount / 100);
  }

  String get getName => _name;
  double get getPrice => _price;
  double get getPriceDiscount => _priceDiscount;
  int get getDiscount => _discount;
  bool get getFeatured => _featured;

  set setName(String name) => _name = name;
  set setPrice(double price) => (price >= 0) ? _price = price : _price = 0;
  set setDiscount(int discount) {
    (discount >= 0 && discount <= 100) ? _discount = discount : _discount = 0;
    _priceDiscount = _price * (1 - _discount / 100);
  }

  set setFeatured(bool featured) => _featured = featured;

  int get getCategoryLength => _categories.length;
  String getCategoryAt(int index) => _categories[index];
  void removeCategoryAt(int index) => _categories.removeAt(index);
  void addCategory(String category) => _categories.add(category);

  Map<String, dynamic> toMap() => {
        'name': _name,
        'price': _price,
        'discount': _discount,
        'featured': _featured,
      };
}
