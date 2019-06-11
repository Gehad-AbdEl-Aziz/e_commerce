import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_the_cart = [
    {
      "name": "Blazer",
      "picture": "image/pro/12.png",
      "price": 100,
      "size": "M",
      "color": "Black",
      "quantity": 1
    },
    {
      "name": "Dress",
      "picture": "image/pro/4.png",
      "price": 250,
      "size": "7",
      "color": "Red",
      "quantity": 1
    },
    {
      "name": "Dress",
      "picture": "image/pro/4.png",
      "price": 250,
      "size": "7",
      "color": "Red",
      "quantity": 1
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            Cart_prod_name: Products_on_the_cart[index]["name"],
            Card_prod_color: Products_on_the_cart[index]["color"],
            Card_prod_qty: Products_on_the_cart[index]["quantity"],
            Card_prod_size: Products_on_the_cart[index]["size"],
            Card_prod_picture: Products_on_the_cart[index]["picture"],
            Card_prod_price: Products_on_the_cart[index]["price"],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final Cart_prod_name;
  final Card_prod_picture;
  final Card_prod_price;
  final Card_prod_size;
  final Card_prod_color;
  final Card_prod_qty;
  Single_cart_product({
    this.Cart_prod_name,
    this.Card_prod_color,
    this.Card_prod_picture,
    this.Card_prod_price,
    this.Card_prod_qty,
    this.Card_prod_size,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        //=========== leading section
        leading: Image.asset(Card_prod_picture,width: 80.0, height: 63.0,),
        //===========  title section
        title: Text(Cart_prod_name),
        //===========  subtitle section
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                //this section for the size of the product
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text('Size:'),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    Card_prod_size,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                // this section for the color of the product
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: Text('Color:'),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    Card_prod_color,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            //======= this section for the price of the product
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "\$${Card_prod_price}",
                style: TextStyle(color: Colors.red, fontSize: 17.0,fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        trailing: new Column(
          children: <Widget>[
            IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
            Text("$Card_prod_qty"),
            IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){})
          ],
        ),
      ),
    );
  }

}

