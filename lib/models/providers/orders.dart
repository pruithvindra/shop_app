import 'dart:convert';

import 'package:shop_app/models/providers/ordersmodel.dart';
import 'package:http/http.dart' as http;
import './cart.dart';
import 'package:flutter/foundation.dart';

class Orders {
  String id;
  DateTime date;
  double amount;
  List<Cart> products;

  Orders({
    this.amount,
    this.date,
    this.id,
    this.products,
  });
}

class Orderlist with ChangeNotifier {
  List<Orders> orderlist = [];

  Future<void> fetchOrders() async {
    final url =
        Uri.https('shop-a5ae1-default-rtdb.firebaseio.com', '/orders.json');

    final response = await http.get(url);
    List<Orders> loadedprod = [];
    final extracteddata = jsonDecode(response.body) as Map<String, dynamic>;

    if (extracteddata == null) {
      return;
    } else {
      extracteddata.forEach((key, value) {
        loadedprod.add(
          Orders(
            amount: value['amount'],
            id: key,
            date: DateTime.parse(value['time']),
            products: (value['products'] as List)
                .map(
                  (e) => Cart(
                    id: e['id'],
                    imageUrl: null,
                    price: e['price'],
                    quantity: e['quantity'],
                    title: e['title'],
                  ),
                )
                .toList(),
          ),
        );
      });
    }

    orderlist = loadedprod;
    notifyListeners();
  }

  Future<void> addOrders({List<Cart> products, double total}) async {
    final url =
        Uri.https('shop-a5ae1-default-rtdb.firebaseio.com', '/orders.json');
    final timestamp = DateTime.now();

    final response = await http.post(
      url,
      body: json.encode(
        {
          'amount': total,
          'time': timestamp.toIso8601String(),
          'products': products
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'price': e.price,
                    'quantity': e.quantity,
                  })
              .toList()
        },
      ),
    );

    orderlist.insert(
      0,
      Orders(
        amount: total,
        date: timestamp,
        id: json.decode(response.body)['name'],
        products: products,
      ),
    );
    notifyListeners();
  }
}
