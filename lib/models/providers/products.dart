import 'package:flutter/cupertino.dart';
import 'package:shop_app/exception/deletingexception.dart';
import './products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isfavorite = false;

  Product({
    @required this.description,
    @required this.id,
    @required this.imageUrl,
    @required this.price,
    @required this.title,
    this.isfavorite,
  });
  Future<void> setfav() async {
    isfavorite = !isfavorite;
    notifyListeners();
    final url = Uri.https(
        'shop-a5ae1-default-rtdb.firebaseio.com', '/products/$id.json');

    await http.patch(
      url,
      body: jsonEncode({
        'isfavorite': isfavorite,
      }),
    );
  }
}

class ProductsList with ChangeNotifier {
  List<Product> prodlist = [];

  Future<void> fetchproducts() async {
    final url =
        Uri.https('shop-a5ae1-default-rtdb.firebaseio.com', '/products.json');

    final response = await http.get(url);

    final extracteddata = jsonDecode(response.body) as Map<String, dynamic>;
    if (extracteddata == null) {
      return;
    }
    final List<Product> loadeddata = [];
    extracteddata.forEach((key, value) {
      loadeddata.add(
        Product(
            id: key,
            title: value['title'],
            description: value['description'],
            imageUrl: value['imageUrl'],
            price: value['price'],
            isfavorite: value['isfavorite']),
      );
    });

    prodlist = loadeddata;
  }

  // void setfav(index) {
  //   final prod = prodlist.firstWhere((element) => element.id == index);
  //   prod.isfavorite = !prod.isfavorite;
  //   // prodlist[index].isfavorite != prodlist[index].isfavorite;
  //   notifyListeners();
  // }

  Future<void> setfav({String key, Product value}) async {
    final prodindex = prodlist.indexWhere((element) => element.id == key);
    bool settedfav = !value.isfavorite;
    if (prodindex >= 0) {
      final url = Uri.https(
          'shop-a5ae1-default-rtdb.firebaseio.com', '/products/$key.json');

      await http.patch(
        url,
        body: jsonEncode({
          'title': value.title,
          'description': value.description,
          'imageUrl': value.imageUrl,
          'price': value.price,
          'isfavorite': settedfav,
        }),
      );
      final prod = prodlist.elementAt(prodindex);
      prod.isfavorite = !prod.isfavorite;
      // prodlist[index].isfavorite != prodlist[index].isfavorite;
      notifyListeners();
    }
  }

  Future<void> updateProduct(String key, Product value) async {
    final prodindex = prodlist.indexWhere((element) => element.id == key);

    if (prodindex >= 0) {
      final url = Uri.https(
          'shop-a5ae1-default-rtdb.firebaseio.com', '/products/$key.json');

      await http.patch(
        url,
        body: jsonEncode({
          'title': value.title,
          'description': value.description,
          'imageUrl': value.imageUrl,
          'price': value.price,
          'isfavorite': value.isfavorite,
        }),
      );
      prodlist[prodindex] = value;
    }
  }

  Future<void> addproduct(Product product) async {
    final url =
        Uri.https('shop-a5ae1-default-rtdb.firebaseio.com', '/products.json');

    final response = await http.post(
      url,
      body: json.encode(
        {
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isfavorite': false,
        },
      ),
    );

    final newprod = Product(
        price: product.price,
        title: product.title,
        imageUrl: product.imageUrl,
        description: product.description,
        id:
            // DateTime.now().toString()
            json.decode(response.body)['name'],
        isfavorite: false);
    prodlist.add(newprod);
    notifyListeners();
    print('${prodlist[prodlist.length - 1].id}');
  }

  Future<void> deleteprod(String key) async {
    final url = Uri.https(
        'shop-a5ae1-default-rtdb.firebaseio.com', '/products/$key.json');
    final existingindex = prodlist.indexWhere((element) => element.id == key);
    var existingitem = prodlist[existingindex];
    prodlist.removeAt(existingindex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      prodlist[existingindex] = existingitem;
      notifyListeners();
      throw del_exception('error found , cannot be deleted');
    }

    existingitem = null;
  }
}
