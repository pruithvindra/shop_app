import 'package:flutter/material.dart';
import 'package:shop_app/addproductscreen/addproductscreen.dart';
import '../models/providers/products.dart';
import 'package:provider/provider.dart';

class Manageproducts extends StatelessWidget {
  static const routename = 'manageproducts';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final products = Provider.of<ProductsList>(context).prodlist;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: height,
        width: width,
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              direction: DismissDirection.endToStart,
              key: UniqueKey(),
              background: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: Icon(Icons.delete_forever),
              ),
              onDismissed: (direction) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${products[index].title} deleted')));
                Provider.of<ProductsList>(context, listen: false)
                    .deleteprod((products[index].id));
              },
              child: ListTile(
                selectedTileColor: Colors.amber,
                leading: CircleAvatar(
                  child: Image.network(products[index].imageUrl),
                ),
                title: Text('${products[index].title}'),
                trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          Addproductscreen.routeName,
                          arguments: products[index].id);
                    }),
              ),
            );
          },
        ),
      ),
    );
  }
}
