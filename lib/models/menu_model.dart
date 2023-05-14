class Menu {
  static Menu? _instance;

  Menu._();

  factory Menu() => _instance ??= Menu._();

  final List<MenuCategory> _categories = List.empty(growable: true);

  MenuCategory getCategoryAt(int index) {
    return _categories[index];
  }

  void addCategory(MenuCategory category) {
    _categories.add(category);
  }

  void removeCategoryAt(int index) {
    _categories.removeAt(index);
  }

  int getCategoryCount() {
    return _categories.length;
  }

  int getTotalItemCount() {
    int count = 0;
    for (var element in _categories) {
      count += element._items.length;
    }
    return count;
  }
}

class MenuCategory {
  String _name;
  final List<MenuItem> _items = List.empty(growable: true);

  MenuCategory(this._name);

  void removeItem(index) {
    _items.removeAt(index);
  }

  String getName() {
    return _name;
  }

  void setName(String name) {
    _name = name;
  }

  MenuItem getItem(int index) {
    return _items[index];
  }

  void addItem(MenuItem item) {
    _items.add(item);
  }

  int getItemCount() {
    return _items.length;
  }
}

class MenuItem {
  String _name;
  double _price;

  MenuItem(this._name, this._price);

  String getName() {
    return _name;
  }

  double getPrice() {
    return _price;
  }

  void setName(String name) {
    _name = name;
  }

  void setPrice(double price) {
    _price = price;
  }
}
