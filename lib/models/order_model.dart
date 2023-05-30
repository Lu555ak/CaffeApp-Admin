import 'package:firebase_database/firebase_database.dart';

class Orders {
  static Orders? _instance;

  Orders._();

  factory Orders() => _instance ??= Orders._();

  final List<Order> _orders = [];

  void syncWithDatabase() {
    _orders.clear();
    DatabaseReference ordersRef = FirebaseDatabase.instance.ref('orders');
    ordersRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
    });
  }
}

class Order {
  final int _table;
  bool _accepted;
  Map<String, int> _order;

  Order(this._table, this._accepted, this._order);

  int get getTable => _table;

  bool get getAccepted => _accepted;
  set setAccepted(bool state) => _accepted = state;

  Map<String, int> get getOrder => _order;
}
