import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Cart with ChangeNotifier {
  String id;
  String title;
  double price;
  String imageUrl;
  int quantity;

  Cart({this.id, this.imageUrl, this.title, this.price, this.quantity});

  Map<String, Cart> cartlist = {};

  double get totalamount {
    double total = 0.0;
    cartlist.forEach((key, value) {
      total += (value.price * value.quantity);
    });
    return total;
  }

  void clearcart() {
    cartlist = {};
  }

  void addcart({price, title, id, imageUrl}) {
    if (cartlist.containsKey(id)) {
      cartlist.update(
          id,
          (value) => Cart(
              id: value.id,
              imageUrl: value.imageUrl,
              price: value.price,
              quantity: value.quantity + 1,
              title: value.title));
    }

    cartlist.putIfAbsent(
        id,
        () => Cart(
            id: id,
            imageUrl: imageUrl,
            price: price,
            quantity: 1,
            title: title));
    notifyListeners();
  }

  void removesingleitem(id) {
    if (!cartlist.containsKey(id)) {
      return;
    }
    if (cartlist[id].quantity > 1) {
      cartlist.update(
          id,
          (value) => Cart(
              id: value.id,
              imageUrl: value.imageUrl,
              price: value.price,
              quantity: value.quantity - 1,
              title: value.title));
    } else {
      cartlist.remove(id);
    }
    notifyListeners();
  }
}
