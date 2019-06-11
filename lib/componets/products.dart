import 'package:flutter/material.dart';
import 'package:e_commerss/pages/product_detiles.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Blazer",
      "picture": "image/pro/12.png",
      "old_price": "150",
      "price": "100",
    },
    {
      "name": "Dress",
      "picture": "image/pro/4.png",
      "old_price": "300",
      "price": "250",
    },
    {
      "name": "Pants",
      "picture": "image/cat/13.png",
      "old_price": "100",
      "price": "90",
    },
    {
      "name": "Hills",
      "picture": "image/cat/6.png",
      "old_price": "90",
      "price": "70",
    },
    {
      "name": "Jacet",
      "picture": "image/pro/11.png",
      "old_price": "250",
      "price": "200",
    },
    {
      "name": "Shoes",
      "picture": "image/pro/18.png",
      "old_price": "150",
      "price": "100",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: product_list.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Single_prod(
          prod_name: product_list[index]['name'],
          prod_picture: product_list[index]['picture'],
          prod_olde_price: product_list[index]['old_price'],
          prod_price: product_list[index]['price'],
        );
      },
    );
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_olde_price;
  final prod_price;
  Single_prod({
    this.prod_name,
    this.prod_olde_price,
    this.prod_picture,
    this.prod_price,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: Text("hero 1"),
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                 // here we are passing values of the product to the product detalis page
                  builder: (context) => new ProductDetalis(
                    prod_details_name: prod_name,
                    prod_details_new_price: prod_price,
                    prod_details_old_price: prod_olde_price,
                    prod_details_picture: prod_picture,
                  ))),
              child: GridTile(
                footer:  Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(
                      prod_name,
                      style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    title: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                              "\$${prod_olde_price}",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            )),
                        Expanded(
                            child: Text(
                              "\$${prod_price}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ),
                child: Image.asset(
                  prod_picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      ),
    );

  }
}
