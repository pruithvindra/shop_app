import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/providers/cart.dart';
import 'package:shop_app/models/providers/orders.dart';

class Cartscreen extends StatefulWidget {
  static const routename = 'cartscreen';

  @override
  _CartscreenState createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cartlist = Provider.of<Cart>(context).cartlist;
    final cartss = Provider.of<Cart>(context);
    bool isordeing = false;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: height * 0.8,
              width: width,
              color: Colors.grey[100],
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Image.network(
                          cartlist.values.toList()[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                        decoration: BoxDecoration(shape: BoxShape.circle),
                      ),
                    ),
                    title: Text(cartlist.values.toList()[index].title),
                    subtitle: Text(
                        'quantity ${cartlist.values.toList()[index].quantity}'),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<Cart>(context, listen: false)
                              .removesingleitem(
                                  cartlist.values.toList()[index].id);
                        }),
                  );
                },
                itemCount: cartlist.length,
              ),
            ),
            Container(
              color: Colors.white70,
              height: height * 0.2,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Colors.black54,
                        Colors.black87,
                      ], tileMode: TileMode.decal),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'total amount \$${cartss.totalamount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: !isordeing
                          ? TextButton(
                              onPressed: (cartss.totalamount <= 0 || isordeing)
                                  ? () {
                                      return null;
                                    }
                                  : () async {
                                      setState(() {
                                        isordeing = true;
                                        print('$isordeing is setted');
                                      });

                                      await Provider.of<Orderlist>(context,
                                              listen: false)
                                          .addOrders(
                                              products:
                                                  cartlist.values.toList(),
                                              total: cartss.totalamount);
                                      setState(() {
                                        isordeing = false;
                                        print('$isordeing');
                                        cartss.clearcart();
                                      });
                                    },
                              child: Text('order'))
                          : CircularProgressIndicator())
                ],
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: AppBar(
      //   title: Container(
      //     child: Text('${cartss.total.toString()}'),
      //   ),
      // ),
    );
  }
}
