class Tables {
  static Tables? _instance;

  Tables._();

  factory Tables() => _instance ??= Tables._();

  final List<CaffeTable> _tables = List.empty(growable: true);

  CaffeTable getTable(int index) {
    return _tables[index];
  }

  void addTable(CaffeTable table) {
    _tables.add(table);
  }

  void removeTable(int index) {
    _tables.removeAt(index);
  }

  int getTableCount() {
    return _tables.length;
  }
}

class CaffeTable {
  int _id;
  String _description;

  CaffeTable(this._id, this._description);

  int getId() {
    return _id;
  }

  void setId(int id) {
    _id = id;
  }

  String getDescription() {
    return _description;
  }

  void setDescription(String description) {
    _description = description;
  }
}
