import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/providers/cart.dart';
import 'package:shop_app/models/providers/products.dart';

class Productscreen extends StatelessWidget {
  static const routename = 'productscreen';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final id = ModalRoute.of(context).settings.arguments;
    final product = Provider.of<ProductsList>(context, listen: true)
        .prodlist
        .firstWhere((element) => element.id == id);
    // bool fav = Provider.of<Product>(context, listen: true).isfavorite;
    bool fav = product.isfavorite;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: height,
        width: width,
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Container(
              child: Text(
                product.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 13,
                        color: Colors.black,
                        offset: Offset(0, 10),
                        spreadRadius: 1)
                  ],
                  border: Border.all(width: 0.1),
                  borderRadius: BorderRadius.circular(20)),
              height: height * 0.4,
              child: Image.network(product.imageUrl),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Container(
              child: Text(
                product.description,
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 3,
                overflow: TextOverflow.fade,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text(
                    product.price.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false).addcart(
                          id: product.id,
                          imageUrl: product.imageUrl,
                          price: product.price,
                          title: product.title);
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    label: Text('Add to Cart'))
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Provider.of<ProductsList>(context, listen: false)
              .setfav(key: id, value: product);
          print("$fav");
        },
        child: Icon(
          fav ? Icons.favorite : Icons.favorite_border_outlined,
          color: Colors.red,
        ),
      ),
    );
  }
}
