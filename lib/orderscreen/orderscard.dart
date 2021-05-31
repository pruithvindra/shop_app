import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/providers/orders.dart';
import 'dart:math';
import './orderscard.dart';

class Ordercard extends StatefulWidget {
  Ordercard({Key key, this.orderslist}) : super(key: key);

  final orderslist;

  @override
  _OrdercardState createState() => _OrdercardState();
}

class _OrdercardState extends State<Ordercard> {
  bool isexpanded = false;

  @override
  Widget build(BuildContext context) {
    Orders orderitem = Provider.of<Orderlist>(context)
        .orderlist
        .firstWhere((element) => element.id == widget.orderslist);
    return Container(
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('${orderitem.id}'),
              subtitle: Text('${orderitem.amount}'),
              trailing: IconButton(
                  icon:
                      Icon(isexpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      isexpanded = !isexpanded;
                    });
                  }),
            ),
            if (isexpanded)
              Container(
                padding: EdgeInsets.all(10),
                height: min(400, orderitem.products.length * 50.0),
                width: double.infinity,
                child: ListView(
                  children: orderitem.products
                      .map((e) => ListTile(
                            title: Text("${e.title}",
                                style: Theme.of(context).textTheme.bodyText1),
                            trailing: Text(
                              '${e.price * e.quantity}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ))
                      .toList(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
