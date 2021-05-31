import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cartscreen/cartscreen.dart';
import 'package:shop_app/models/providers/products.dart';
import 'package:shop_app/orderscreen/orderscreen.dart';
import './itemwidget.dart';
import './drawer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> pullrefresh() async {
    Provider.of<ProductsList>(context, listen: false).fetchproducts();
    //     .then((value) {
    //   setState(
    //     () {
    //       isloading = false;
    //     },
    //   );
    // }

    // );
  }

  bool init = true;

  bool isloading = false;

  // @override
  // void didChangeDependencies() {
  //   if (init) {
  //     setState(() {
  //       isloading = true;
  //     });

  //     Provider.of<ProductsList>(context, listen: false)
  //         .fetchproducts()
  //         .then((value) {
  //       setState(
  //         () {
  //           isloading = false;
  //         },
  //       );
  //     });
  //   }
  //   init = false;

  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'cart-on',
            style: TextStyle(fontSize: 50),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart_sharp),
              onPressed: () {
                Navigator.pushNamed(context, Cartscreen.routename);
              },
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => pullrefresh(),
          child: FutureBuilder(
            future: Provider.of<ProductsList>(context, listen: false)
                .fetchproducts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ));
              } else if (snapshot.error != null) {
                return Center(
                  child: Text('an error occurred :['),
                );
              } else {
                return Container(
                  height: height,
                  width: width,
                  child: Itemwidget(),
                );
              }
            },
          ),
        ),
        drawer: Drawerwidget());
  }
}
