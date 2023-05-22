import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  int generateFreeId() {
    int id = 1;
    List<int> ids = List.empty(growable: true);

    for (var element in _tables) {
      ids.add(element._id);
    }

    while (id < 999) {
      if (ids.contains(id)) {
        id++;
      } else {
        return id;
      }
    }
    return 0;
  }

  bool idExists(int id) {
    return _tables.any((element) => element._id == id);
  }

  Future saveToDatabase() async {
    /*var collection = FirebaseFirestore.instance.collection('tables');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }

    for (var element in _tables) {
      await FirebaseFirestore.instance.collection("tables").add(
          {"id": element.getId(), "description": element.getDescription()});
    }*/
  }

  Future loadFromDatabase() async {
    /*await FirebaseFirestore.instance
        .collection("tables")
        .get()
        .then((snapshot) {
      for (var element in snapshot.docs) {
        addTable(
            CaffeTable(element.data()["id"], element.data()["description"]));
      }
    });*/
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

  String generateQRCodeData() {
    return "CaffeAppTable: $_id";
  }
}
