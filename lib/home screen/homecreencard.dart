import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/providers/cart.dart';
import 'package:shop_app/models/providers/products.dart';
import 'package:shop_app/productscreen/productscreen.dart';

class Homescreen_gridcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Product>(context);

    return GestureDetector(
      onTap: () {
        return Navigator.of(context)
            .pushNamed(Productscreen.routename, arguments: products.id);
      },
      child: Container(
          margin: EdgeInsets.all(10),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Container(
                  height: 400,
                  width: 200,
                  child: Image.network(
                    products.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        child: Text(
                          products.title,
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        products.price.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        children: [
                          IconButton(
                              color: Colors.red,
                              icon: products.isfavorite
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(Icons.favorite_border_rounded),
                              onPressed: () {
                                products.setfav();
                              }),
                          IconButton(
                            icon: Icon(
                              Icons.add_shopping_cart_sharp,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Provider.of<Cart>(context, listen: false).addcart(
                                  id: products.id,
                                  imageUrl: products.imageUrl,
                                  price: products.price,
                                  title: products.title);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
