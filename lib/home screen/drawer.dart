import 'package:flutter/material.dart';
import 'package:shop_app/manageproducts/manageproducts.dart';
import '../addproductscreen/addproductscreen.dart';
import '../orderscreen/orderscreen.dart';

class Drawerwidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.black54),
            child: Text(
              'Hello there!',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Orderscreen.routename);
            },
            child: ListTile(
              title: Text('Orders'),
              trailing: Icon(Icons.article_rounded),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Addproductscreen.routeName);
            },
            child: ListTile(
              title: Text('Add product'),
              trailing: Icon(Icons.add_box),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Manageproducts.routename);
            },
            child: ListTile(
              title: Text('Manage Products'),
              trailing: Icon(Icons.edit),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Orderscreen.routename);
            },
            child: ListTile(
              title: Text('orders'),
              trailing: Icon(Icons.book),
            ),
          )
        ],
      ),
    );
  }
}
