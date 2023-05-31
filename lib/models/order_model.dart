class Order {
  final int _table;
  bool _accepted;
  final Map<String, int> _order;
  final Map<String, int> _creditOrder;

  Order(this._table, this._accepted, this._order, this._creditOrder);

  int get getTable => _table;

  bool get getAccepted => _accepted;
  set setAccepted(bool state) => _accepted = state;

  Map<String, int> get getOrder => _order;
  Map<String, int> get getCreditOrder => _creditOrder;
}
