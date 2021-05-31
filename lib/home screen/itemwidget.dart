import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/providers/products.dart';
import './homecreencard.dart';

class Itemwidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsList>(context).prodlist;
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 600,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 200),
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
              //check this out i have done this in another method, (brooooooo, may be new for u in future )
              value: products[index],
              child: Homescreen_gridcard());
        });
  }
}
