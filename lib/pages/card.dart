import 'package:flutter/material.dart';
// my imports
import 'package:e_commerss/componets/cart_products.dart';
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,// 0.0 3l4an a4el elshadw mn elAppBar
        backgroundColor: Colors.red,
        title: Text('Cart'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}
              ),
        ],
      ),

      body: Cart_products(),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('Total : '),
                subtitle: Text("\$230"),),),
            Expanded(
                child: MaterialButton(onPressed: (){},
                  child: Text("Check out",style: TextStyle(color: Colors.white),),
                color: Colors.red,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
