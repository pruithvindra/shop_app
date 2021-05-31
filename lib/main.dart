import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/addproductscreen/addproductscreen.dart';
import 'package:shop_app/authscreen/authscreen.dart';
import 'package:shop_app/cartscreen/cartscreen.dart';
import 'package:shop_app/models/providers/auth.dart';
import 'package:shop_app/models/providers/orders.dart';
import './home screen/homecreen.dart';
import './models/providers/products.dart';
import './productscreen/productscreen.dart';
import './models/providers/cart.dart';
import './orderscreen/orderscreen.dart';
import './manageproducts/manageproducts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProductsList(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orderlist(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.white),
          primaryTextTheme: GoogleFonts.sacramentoTextTheme(),
          textTheme: TextTheme(
              bodyText1: GoogleFonts.robotoCondensed(
                  fontSize: 20, color: Colors.black),
              bodyText2: GoogleFonts.robotoCondensed(
                  fontSize: 20, color: Colors.white)),
        ),
        home: AuthScreen(),
        initialRoute: '/',
        routes: {
          Productscreen.routename: (ctx) {
            return Productscreen();
          },
          Cartscreen.routename: (ctx) => Cartscreen(),
          Orderscreen.routename: (ctx) => Orderscreen(),
          Addproductscreen.routeName: (ctx) => Addproductscreen(),
          Manageproducts.routename: (ctx) => Manageproducts(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
        },
      ),
    );
  }
}
