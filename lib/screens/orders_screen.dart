import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unwrapp/widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        // future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitDoubleBounce(
                color: Colors.white,
                size: 100.0,
              ),
            );
          } else {
            if (dataSnapshot.error != null) {
              // ...
              // Do error handling stuff
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return null;
              // return Consumer<Orders>(
              //   builder: (context, orderData, child) => ListView.builder(
              //     itemCount: orderData.orders.length,
              //     itemBuilder: (context, i) => OrderItem(orderData.orders[i]),
              //   ),
              // );
            }
          }
        },
      ),
    );
  }
}
