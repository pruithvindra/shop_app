import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/providers/orders.dart';
import 'package:shop_app/models/providers/ordersmodel.dart';
import 'dart:math';
import './orderscard.dart';

class Orderscreen extends StatelessWidget {
  static const routename = 'orderscreen';

  @override
  Widget build(BuildContext context) {
    print('h');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        extendBodyBehindAppBar: true,
        body: FutureBuilder(
          future: Provider.of<Orderlist>(context, listen: false).fetchOrders(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await Provider.of<Orderlist>(context, listen: false)
                            .fetchOrders();
                      },
                      child: Container(
                        height: height,
                        width: width,
                        child: Consumer<Orderlist>(
                          builder: (context, value, child) => ListView.builder(
                            itemCount: value.orderlist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Ordercard(
                                  orderslist: value.orderlist[index].id);
                            },
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
