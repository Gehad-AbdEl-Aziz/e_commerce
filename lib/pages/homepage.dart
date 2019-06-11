import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
// my own imports
import 'package:e_commerss/componets/herizontal_listview.dart';
import 'package:e_commerss/componets/products.dart';
import 'package:e_commerss/pages/card.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override

  // Carousel
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.scaleDown,
        dotSize: 6.0,
        indicatorBgPadding: 7.0,
        images: [
          AssetImage('image/pro/4.png'),
          AssetImage('image/pro/11.png'),
          AssetImage('image/pro/1.png'),
          AssetImage('image/pro/7.png'),
          AssetImage('image/pro/9.png'),
        ],
        autoplay: true,
        //animationCurve: Curve.fastOutSlowIn,
        animationDuration: Duration(microseconds: 1000),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,// 0.0 3l4an a4el elshadw mn elAppBar
        backgroundColor: Colors.red,
        title: Text('Fashion'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
              }),
        ],
      ),
      //Start in drawer 2/6/2019
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            // header in drawer
            new UserAccountsDrawerHeader(
              accountName: Text("Gehad Abdelaziz"),
              accountEmail: Text("Gehad_zezo25@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Colors.red),
            ),
            // body drawer
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My account'),
                leading: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My orders'),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
              },
              child: ListTile(
                title: Text('Shopping cart'),
                leading: Icon(
                  Icons.shopping_cart,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>))
              },
              child: ListTile(
                title: Text('Categoris'),
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My favorite'),
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Setting'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About '),
                leading: Icon(Icons.help,color: Colors.green,),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          // image Carousel start here
          image_carousel,
          // padding widget
          new Padding(padding: EdgeInsets.all(8.0),
            child: new Text('Categories',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),),
          // Horizontal List View begins here
          HorizontalList(),
// padding widget
          new Padding(padding: EdgeInsets.all(20.0),
            child: new Text('Recent Products',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),),
          Container(
            height: 320,
            child: Products(),
          ),

        ],
      ),
    );
  }
}