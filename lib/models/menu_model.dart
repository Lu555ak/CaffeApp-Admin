import 'dart:ffi';

class Menu {
  static Menu? _instance;

  Menu._();

  factory Menu() => _instance ??= Menu._();

  List<MenuCategory> menu = List.empty(growable: true);

  List<MenuCategory> getMenu() {
    return menu;
  }

  void addCategory(MenuCategory category) {
    menu.add(category);
  }

  int itemCount() {
    int count = 0;
    for (var element in menu) {
      count += element.items.length;
    }

    return count;
  }
}

class MenuCategory {
  String name;
  List<MenuItem> items = List.empty(growable: true);

  MenuCategory(this.name);

  List<MenuItem> getCategory() {
    return items;
  }

  void setName(String name) => this.name = name;

  void addItem(MenuItem item) => items.add(item);
}

class MenuItem {
  String name;
  double price;

  MenuItem(this.name, this.price);
}
